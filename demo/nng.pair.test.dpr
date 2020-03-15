program nng.pair.test;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  nng.api in '..\nng.api.pas',
  nng.api.protocol.pair1 in '..\nng.api.protocol.pair1.pas',
  nng.api.constants in '..\nng.api.constants.pas',
  nng.api.types in '..\nng.api.types.pas';

var
  S1, S2: Tnng_socket;
  M: Pnng_msg;
  I, N: Integer;
  L: Word;
  J: Cardinal;
  S: PAnsiChar;
begin
  try
    nng_pair_open(S1);
    nng_pair_open(S2);

    nng_listen(S1, 'tcp://localhost:5555', nil, 0);
    nng_dial(S2, 'tcp://localhost:5555', nil, Ord(NNG_FLAG_NONBLOCK));

    N := 0;
    for I := 1 to 10000 do
    begin
      nng_msg_alloc(M, 0);

      nng_msg_append_u16(M, 6);
      nng_msg_append(M, PAnsiChar('HELLO'), 6);
      nng_msg_append_u32(M, I);

      nng_sendmsg(S1, M, 0);
      nng_recvmsg(S2, M, 0);

      nng_msg_trim_u16(M, L);
      Assert(L = 6);
      S := nng_msg_body(M);
      Assert(S = 'HELLO');
      nng_msg_trim(M, L);
      nng_msg_trim_u32(M, J);
      Assert(J = Cardinal(I));

      nng_msg_free(M);
      Inc(N);
    end;

    WriteLn(Format('%d messages received', [N]));

    nng_close(S1);
    nng_close(S2);

    WriteLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
