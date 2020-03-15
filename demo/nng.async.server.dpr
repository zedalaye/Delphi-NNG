program nng.async.server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Winapi.Windows,
  System.SysUtils,
  nng.api in '..\nng.api.pas',
  nng.api.protocol.reqrep0.rep in '..\nng.api.protocol.reqrep0.rep.pas',
  nng.api.utils in '..\nng.api.utils.pas';

const
  PARALLEL = 128;

type
  TWorkState = (INIT, RECV, WAIT, SEND);
  PWork = ^TWork;
  TWork = record
    state: TWorkState;
    aio: Pnng_aio;
    msg: Pnng_msg;
    ctx: Tnng_ctx;
  end;

procedure fatal(const method: string; error_code: Integer);
begin
  raise Exception.CreateFmt('%s: %s', [method, nng_strerror(error_code)]);
end;

procedure server_cb(arg: Pointer); cdecl;
var
  work: PWork;
  msg: Pnng_msg;
  rv: Integer;
  when: Cardinal;
begin
  work := PWork(arg);

  case work^.state of
  INIT:
    begin
      work^.state := RECV;
      nng_ctx_recv(work^.ctx, work^.aio);
    end;

  RECV:
    begin
      rv := nng_aio_result(work^.aio);
      if rv <> 0 then
        fatal('nng_ctx_recv', rv);
      msg := nng_aio_get_msg(work^.aio);
      rv := nng_msg_trim_u32(msg, when);
      if rv <> 0 then
      begin
        // bad message, just ignore it.
        nng_msg_free(msg);
        nng_ctx_recv(work^.ctx, work^.aio);
      end
      else
      begin
        work^.msg   := msg;
        work^.state := WAIT;
        nng_sleep_aio(when, work^.aio);
      end;
    end;

  WAIT:
    begin
      // We could add more data to the message here.
      nng_aio_set_msg(work^.aio, work^.msg);
      work^.msg   := nil;
      work^.state := SEND;
      nng_ctx_send(work^.ctx, work^.aio);
    end;

  SEND:
    begin
  		rv := nng_aio_result(work^.aio);
      if rv <> 0 then
      begin
        nng_msg_free(work^.msg);
        fatal('nng_ctx_send', rv);
      end;
      work^.state := RECV;
      nng_ctx_recv(work^.ctx, work^.aio);
    end

  else
    fatal('bad state!', Ord(NNG_ESTATE));
  end;
end;

function alloc_work(sock: Tnng_socket): PWork;
var
	w: PWork;
	rv: Integer;
begin
  w := nng_alloc(SizeOf(w^));
  if w = nil then
    fatal('nng_alloc', Ord(NNG_ENOMEM));

  rv := nng_aio_alloc(w^.aio, server_cb, w);
  if rv <> 0 then
    fatal('nng_aio_alloc', rv);

  rv := nng_ctx_open(w^.ctx, sock);
  if rv <> 0 then
    fatal('nng_ctx_open', rv);

  w^.state := INIT;
  Result := w;
end;

function server(const url: string): Integer;
var
	sock: Tnng_socket;
  works: array[0..PARALLEL - 1] of PWork;
  rv: Integer;
  t1, t2: Cardinal;
begin
  t1 := GetTickCount;

  (* Create the socket. *)
	rv := nng_rep_open(sock);
	if (rv <> 0) then
    fatal('nng_rep0_open', rv);

	for var i := 0 to PARALLEL - 1 do
    works[i] := alloc_work(sock);

  rv := nng_listen(sock, PAnsiChar(AnsiString(url)), nil, 0);
  if rv <> 0 then
    fatal('nng_listen', rv);

  for var i := 0 to PARALLEL - 1 do
    server_cb(works[i]);

  t2 := GetTickCount;
  WriteLn(Format('Ready, app boot took %d milliseconds.', [t2 - t1]));

  while True do
    nng_msleep(3600000);
end;

begin
  try
    if ParamCount = 1 then
    begin
      var rc := server(ParamStr(1));
      if rc <> 0 then
        ExitCode := 1;
    end
    else
      WriteLn(ErrOutput, Format('Usage: %s <url>', [ParamStr(0)]));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
