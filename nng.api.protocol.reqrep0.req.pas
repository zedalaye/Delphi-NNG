unit nng.api.protocol.reqrep0.req;

interface

uses
  nng.api;

function nng_req0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_req0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_req_open: function(var s: Tnng_socket): Integer; cdecl = nng_req0_open;
  nng_req_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_req0_open_raw;

const
  NNG_REQ0_SELF = $30;
  NNG_REQ0_PEER = $31;
  NNG_REQ0_SELF_NAME = 'req';
  NNG_REQ0_PEER_NAME = 'rep';

  NNG_OPT_REQ_RESENDTIME = 'req:resend-time';

implementation

end.
