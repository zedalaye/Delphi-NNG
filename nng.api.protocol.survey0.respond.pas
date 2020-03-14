unit nng.api.protocol.survey0.respond;

interface

uses
  nng.api;

function nng_respondent0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_respondent0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_req_open: function(var s: Tnng_socket): Integer; cdecl = nng_respondent0_open;
  nng_req_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_respondent0_open_raw;

const
  NNG_RESPONDENT0_SELF = $63;
  NNG_RESPONDENT0_PEER = $62;
  NNG_RESPONDENT0_SELF_NAME = 'respondent';
  NNG_RESPONDENT0_PEER_NAME = 'surveyor';

implementation

end.
