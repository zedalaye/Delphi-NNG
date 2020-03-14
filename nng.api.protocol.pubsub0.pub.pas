unit nng.api.protocol.pubsub0.pub;

interface

uses
  nng.api;

function nng_pub0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_pub0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_pub_open: function(var s: Tnng_socket): Integer; cdecl = nng_pub0_open;
  nng_pub_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_pub0_open_raw;

implementation

end.
