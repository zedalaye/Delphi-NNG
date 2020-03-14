unit nng.api.protocol.pipeline0.pull;

interface

uses
  nng.api;

function nng_pull0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_pull0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_pull_open: function(var s: Tnng_socket): Integer; cdecl = nng_pull0_open;
  nng_pull_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_pull0_open_raw;

implementation

end.
