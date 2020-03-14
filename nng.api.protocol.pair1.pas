unit nng.api.protocol.pair1;

interface

uses
  nng.api;

function nng_pair1_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_pair1_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_pair1_open_poly(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_pair_open: function(var s: Tnng_socket): Integer; cdecl = nng_pair1_open;
  nng_pair_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_pair1_open_raw;
  nng_pair_open_poly: function(var s: Tnng_socket): Integer; cdecl = nng_pair1_open_poly;

const
  NNG_OPT_PAIR1_POLY = 'pair1:polyamorous';
  NNG_PAIR1_SELF = $11;
  NNG_PAIR1_PEER = $11;
  NNG_PAIR1_SELF_NAME = 'pair1';
  NNG_PAIR1_PEER_NAME = 'pair1';

implementation

end.
