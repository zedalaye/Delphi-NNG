unit nng.api.protocol.reqrep0.rep;

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
  nng.api;

function nng_rep0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_rep0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_rep_open: function(var s: Tnng_socket): Integer; cdecl = nng_rep0_open;
  nng_rep_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_rep0_open_raw;

const
  NNG_REP0_SELF = $31;
  NNG_REP0_PEER = $30;
  NNG_REP0_SELF_NAME = 'rep';
  NNG_REP0_PEER_NAME = 'req';

implementation

end.
