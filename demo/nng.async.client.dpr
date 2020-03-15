program nng.async.client;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Winapi.Windows,
  System.SysUtils,
  nng.api in '..\nng.api.pas',
  nng.api.protocol.reqrep0.req in '..\nng.api.protocol.reqrep0.req.pas',
  nng.api.utils in '..\nng.api.utils.pas',
  nng.api.constants in '..\nng.api.constants.pas',
  nng.api.types in '..\nng.api.types.pas';

procedure fatal(const method: string; error_code: Integer);
begin
  raise Exception.CreateFmt('%s: %s', [method, nng_strerror(error_code)]);
end;

function client(const url, msecstr: string): Integer;
var
	sock: Tnng_socket;
	rv: Integer;
	msg: Pnng_msg;
	start, &end: Tnng_time;
  t1, t2: Cardinal;
  msec: Cardinal;
begin
	msec := StrToInt(msecstr);

  t1 := GetTickCount;
  rv := nng_req0_open(sock);
  t2 := GetTickCount;

	if (rv <> 0) then
		fatal('nng_req0_open', rv);

  WriteLn(Format('nng_req0_open took %d milliseconds.', [t2 - t1]));

  rv := nng_dial(sock, PAnsichar(AnsiString(url)), nil, 0);
	if (rv <> 0) then
		fatal('nng_dial', rv);

	start := nng_clock();

  rv := nng_msg_alloc(msg, 0);
	if (rv <> 0) then
		fatal('nng_msg_alloc', rv);

  rv := nng_msg_append_u32(msg, msec);
	if (rv <> 0) then
		fatal('nng_msg_append_u32', rv);

  rv := nng_sendmsg(sock, msg, 0);
	if (rv <> 0) then
		fatal('nng_send', rv);

  rv := nng_recvmsg(sock, msg, 0);
	if (rv <> 0) then
		fatal('nng_recvmsg', rv);

	&end := nng_clock();
	nng_msg_free(msg);
	nng_close(sock);

	WriteLn(Format('Request took %d milliseconds.', [&end - start]));
  Result := 0;
end;

var
  rc: Integer;

begin
  try
    if ParamCount = 2 then
    begin
      rc := client(ParamStr(1), ParamStr(2));
      if rc <> 0 then
        ExitCode := 1;
    end
    else
      WriteLn(ErrOutput, Format('Usage: %s <url> <secs>', [ParamStr(0)]));
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
