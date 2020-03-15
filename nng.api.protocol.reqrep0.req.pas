unit nng.api.protocol.reqrep0.req;

//
// Copyright 2020 Staysail Systems, Inc. <info@staysail.tech>
// Copyright 2018 Capitar IT Group BV <info@capitar.com>
//
// This software is supplied under the terms of the MIT License, a
// copy of which should be located in the distribution where this
// file was obtained (LICENSE.txt).  A copy of the license may also be
// found online at https://opensource.org/licenses/MIT.
//

// Delphi bindings ®2020 by Pierre Yager <pierre.y@gmail.com>

interface

uses
  nng.api.types,
  nng.api.constants;

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
