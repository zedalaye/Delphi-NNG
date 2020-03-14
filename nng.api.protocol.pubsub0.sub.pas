unit nng.api.protocol.pubsub0.sub;

interface

uses
  nng.api;

function nng_sub0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_sub0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_sub_open: function(var s: Tnng_socket): Integer; cdecl = nng_sub0_open;
  nng_sub_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_sub0_open_raw;

const
  NNG_OPT_SUB_SUBSCRIBE = 'sub:subscribe';
  NNG_OPT_SUB_UNSUBSCRIBE = 'sub:unsubscribe';

  NNG_OPT_SUB_PREFNEW = 'sub:prefnew';

implementation

end.
