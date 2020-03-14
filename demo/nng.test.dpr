program nng.test;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  nng.api in '..\nng.api.pas',
  nng.api.protocol.pair1 in '..\nng.api.protocol.pair1.pas';

var
  S1, S2: Tnng_socket;
  M: Pnng_msg;

begin
  try
    nng_pair_open(S1);
    nng_pair_open(S2);

    nng_listen(S1, 'tcp://localhost:5555', nil, 0);
    nng_dial(S2, 'tcp://localhost:5555', nil, Ord(NNG_FLAG_NONBLOCK));

    for var I := 0 to 10000 do
    begin
      Write('.');
      nng_msg_alloc(M, 0);
      nng_msg_append(M, PAnsiChar('HELLO'), 6);
      nng_sendmsg(S1, M, 0);
      nng_recvmsg(S2, M, 0);
      Assert(nng_msg_len(M) = Length('HELLO') + 1);
      nng_msg_free(M);
    end;

    nng_close(S1);
    nng_close(S2);

    WriteLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
