unit nng.api.protocol.bus0;

interface

uses
  nng.api;

function nng_bus0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_bus0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_bus_open: function(var s: Tnng_socket): Integer; cdecl = nng_bus0_open;
  nng_bus_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_bus0_open_raw;

implementation

end.
