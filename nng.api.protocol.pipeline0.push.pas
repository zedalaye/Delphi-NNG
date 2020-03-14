unit nng.api.protocol.pipeline0.push;

interface

uses
  nng.api;

function nng_push0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_push0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_push_open: function(var s: Tnng_socket): Integer; cdecl = nng_push0_open;
  nng_push_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_push0_open_raw;

implementation

end.
