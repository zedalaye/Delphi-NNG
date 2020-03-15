unit nng.api.tls.engine;

//
// Copyright 2020 Staysail Systems, Inc. <info@staysail.tech>
//
// This software is supplied under the terms of the MIT License, a
// copy of which should be located in the distribution where this
// file was obtained (LICENSE.txt).  A copy of the license may also be
// found online at https://opensource.org/licenses/MIT.
//

// Delphi bindings ®2020 by Pierre Yager <pierre.y@gmail.com>

// This file is used to enable external TLS "engines", so
// that third party TLS libraries can be plugged in

interface

uses
  nng.api.types,
  nng.api.constants,
  nng.api.tls;

// Locking theory statement for TLS engines.  The engine is assumed
// operate only from the context of threads called by the common
// framework.  That is to say, the callbacks made by the engine
// should always be on a thread that has context from the framework
// calling into the engine.  This means that the lower level send
// and receive functions can assume that they have lock ownership
// inherited on the stack.

// nng_tls_engine_conn represents the engine-specific private
// state for a TLS connection.  It is provided here for type
// safety.  Engine implementations should provide the structure
// definition locally.
type
  Pnng_tls_engine_conn = ^Tnng_tls_engine_conn;
  Tnng_tls_engine_conn = record
  end;

// nng_tls_engine_config represents the engine-specific private
// state for the TLS configuration.  It is provided here for type
// safety.  Engine implementations should provide the structure
// definition locally.
type
  Pnng_tls_engine_config = ^Tnng_tls_engine_config;
  Tnng_tls_engine_config = record
  end;

  Pnng_tls_engine_conn_ops = ^Tnng_tls_engine_conn_ops;
  Tnng_tls_engine_conn_ops = record
    // size is the size of the engine's per-connection state.
    // The framework will allocate this on behalf of the engine.
    // Typically this will be sizeof (struct nng_tls_engine_conn).
    size: NativeUInt;

    // init is used to initialize a connection object.
    // The passed in connection state will be aligned naturally,
    // and zeroed.  On success this returns 0, else an NNG error code.
    init: function(conn: Pnng_tls_engine_conn; data: Pointer; config: Pnng_tls_engine_config): Integer; cdecl;

    // fini destroys a connection object.  This will
    // be called only when no other external use of the connection
    // object exists, and only on fully initialed connection objects.
    fini: procedure(conn: Pnng_tls_engine_conn); cdecl;

    // close closes the connection object, but should not
    // deallocate any memory.  It may also issue a TLS close-notify.
    close: procedure(conn: Pnng_tls_engine_conn); cdecl;

    // handshake attempts to complete the SSL handshake phase.
    // It returns zero on success, or an error if one occurred.
    // The value NNG_EAGAIN should be returned if underlying I/O
    // is required to be completed first.  The framework will
    // ensure that the handshake completes before sending any data
    // down.
    handshake: function(conn: Pnng_tls_engine_conn): Integer; cdecl;

    // recv attempts to read data (decrypted) from the connection.
    // It returns 0 on success, otherwise an error.  The implementation
    // should return NNG_EAGAIN if I/O to the underlying stream is
    // required to complete the operation.  On success, the count
    // is updated to reflect the number of bytes actually received.
    recv: function(conn: Pnng_tls_engine_conn; data: PByte; var sz: NativeUInt): Integer; cdecl;

    // send attempts to write data to the underlying connection.
    // It returns zero on success, otherwise an error. The implementation
    // should return NNG_EAGAIN if I/O to the underlying stream is
    // required to complete the operation.  On success, the count
    // is updated to reflect the number of bytes actually sent.
    send: function(conn: Pnng_tls_engine_conn; const data: PByte; var sz: NativeUInt): Integer; cdecl;

    // verified returns true if the connection is fully
    // TLS verified, false otherwise.
    verified: function(conn: Pnng_tls_engine_conn): Boolean; cdecl;
  end;

  Pnng_tls_engine_config_ops = ^Tnng_tls_engine_config_ops;
  Tnng_tls_engine_config_ops = record
    // size is the size of the engine's configuration object.
    // The framework will allocate this on behalf of the engine.
    // Typically this will be sizeof (struct nng_tls_engine_config).
    size: NativeUInt;

    // init prepares the configuration object object.
    // The mode indicates whether the object should be
    // initialized for use as a TLS server or client.
    // The config passed in will be aligned on a 64-bit boundary,
    // and will be initialized to zero.  On success this returns
    // 0, else an NNG error code.
    init: function(config: Pnng_tls_engine_config; mode: Tnng_tls_mode): Integer; cdecl;

    // fini is used to tear down the configuration object.
    // This will only be called on objects that have been properly
    // initialized with nte_config_init.
    fini: procedure(config: Pnng_tls_engine_config); cdecl;

    // server is used to set the server name.  This can be used in SNI,
    // and will also be used on the client to validate the identity.
    // If this is not set, then no verification will be performed.
    server: function(config: Pnng_tls_engine_config; const name: PAnsiChar):Integer; cdecl;

    // auth is used to configure the authentication mode.  Values:
    // NNG_AUTH_MODE_NONE
    //   No validation of the peer is performed.  Public facing
    //   servers often use this.
    // NNG_AUTH_MODE_OPTIONAL
    //   The peer's identity is validated if a certificate is presented.
    //   This is typically useful on servers.
    // NNG_AUTH_MODE_REQUIRED
    //   The peer's certificate must be present and is verified.
    //   This is standard for the client, and on servers it is used
    //   when client (mutual) authentication is needed.
    auth: function(config: Pnng_tls_engine_config; mode: Tnng_tls_auth_mode): Integer; cdecl;

    // ca_chain sets the configuration authorities that will be
    // used to validate peers.  An optional CRL is supplied as well.
    // Both values are C strings (NUL terminated) containing
    // PEM data.  There may be multiple PEM blocks.  The
    // CRL may be NULL if not needed.
    ca_chain: function(config: Pnng_tls_engine_config; const certs, clr: PAnsiChar): Integer; cdecl;

    // own_cert configures our identity -- the certificate containing
    // our public key, our private key (which might be encrypted), and
    // potentially a password used to decrypt the private key.
    // All of these are C strings.  The cert may actually be a chain
    // which will be presented to our peer.   This function may be
    // called multiple times to register different keys with different
    // parameters on a server.  (For example, once for RSA parameters,
    // and again later with EC parameters.)  The certificate and the
    // private key may be presented in the same file.  The implementation
    // is responsible for parsing out the relevant data.  If the password
    // is NULL, then the key file should be unencrypted.  The supplied
    // password may be ignored if the key is not encrypted.  Not all
    // engine implementations need support encryption of the key.
    own_cert: function(config: Pnng_tls_engine_config; const cert, key, pass: PAnsiChar): Integer; cdecl;

    // version configures the minimum and maximum TLS versions.  The
    // engine should default to supporting TLS1.0 through 1.2, and
    // optionally 1.3 if it can.  The engine should restrict the
    // the requested range to what it can support -- if no version
    // within the range is supported (such as if NNG_TLS_1_3 is
    // specified for both min and max, and the engine lacks support
    // for v1.3, then NNG_ENOTSUP should be returned.
    version: function(config: Pnng_tls_engine_config; min_ver, max_ver: Tnng_tls_version): Integer; cdecl;
  end;

  Tnng_tls_engine_version = (
    NNG_TLS_ENGINE_V0      = 0,
    NNG_TLS_ENGINE_V1      = 1,
    NNG_TLS_ENGINE_VERSION = NNG_TLS_ENGINE_V1
  );

  Pnng_tls_engine = ^Tnng_tls_engine;
  Tnng_tls_engine = record
    // _version is the engine version.  This for now must
    // be NNG_TLS_ENGINE_VERSION.  If the version does not match
    // then registration of the engine will fail.
    version: Tnng_tls_engine_version;

    // config_ops is the operations for TLS configuration objects.
    config_ops: Pnng_tls_engine_config_ops;

    // conn_ops is the operations for TLS connections (stream-oriented).
    conn_ops: Pnng_tls_engine_conn_ops;

    // name contains the name of the engine, for example "wolfSSL".
    // It is acceptable to append a version number as well.
    name: PAnsiChar;

    // description contains a human readable description.  This can
    // supply information about the backing library, for example
    // "mbed TLS v2.7"
    description: PAnsiChar;

    // fips_mode is true if the engine is in FIPS mode.
    // It is expected that this will be enabled either at compile
    // time, or via environment variables at engine initialization.
    // FIPS mode cannot be changed once the engine is registered.
    fips_mode: Boolean;
  end;

function nng_tls_engine_register(const engine: Pnng_tls_engine): Integer; cdecl; external NNG_LIB;

// nng_tls_engine_send is called by the engine to send data over the
// underlying connection.  It returns zero on success, NNG_EAGAIN if
// the operation can't be completed yet (the transport is busy and cannot
// accept more data yet), or some other error.  On success the count is
// updated with the number of bytes actually sent.  The first argument
// is the context structure passed in when starting the engine.
function nng_tls_engine_send(context: Pointer; const data: PByte; sz: NativeUInt): Integer; cdecl; external NNG_LIB;

// nng_tls_engine_recv is called byu the engine to receive data over
// the underlying connection.  It returns zero on success, NNG_EAGAIN
// if the operation can't be completed yet (there is no data available
// for reading), or some other error.  On success the count is updated
// with the number of bytes actually received.
function nng_tls_engine_recv(context: Pointer; data: PByte; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;

implementation

end.
