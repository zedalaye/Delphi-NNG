unit nng.api.protocol.pair0;

interface

uses
  nng.api;

function nng_pair0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_pair0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_pair_open: function(var s: Tnng_socket): Integer; cdecl = nng_pair0_open;
  nng_pair_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_pair0_open_raw;

implementation

end.
