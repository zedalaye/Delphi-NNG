unit nng.api.protocol.survey0.survey;

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

function nng_surveyor0_open(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;
function nng_surveyor0_open_raw(var s: Tnng_socket): Integer; cdecl; external NNG_LIB;

const
  nng_surveyor_open: function(var s: Tnng_socket): Integer; cdecl = nng_surveyor0_open;
  nng_surveyor_open_raw: function(var s: Tnng_socket): Integer; cdecl = nng_surveyor0_open_raw;

const
  NNG_SURVEYOR0_SELF = $62;
  NNG_SURVEYOR0_PEER = $63;
  NNG_SURVEYOR0_SELF_NAME = 'surveyor';
  NNG_SURVEYOR0_PEER_NAME = 'respondent';

  NNG_OPT_SURVEYOR_SURVEYTIME = 'surveyor:survey-time';

implementation

end.
