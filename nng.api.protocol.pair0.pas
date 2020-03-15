unit nng.api.protocol.pair0;

//
// Copyright 2018 Staysail Systems, Inc. <info@staysail.tech>
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

function nng_pair0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_pair0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_pair_open: function(var s: Tnng_socket): Integer; cdecl = nng_pair0_open;
  nng_pair_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_pair0_open_raw;

implementation

end.
