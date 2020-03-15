unit nng.api.constants;

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

const
  NNG_LIB = 'nng.dll';

// NNG Library & API version.
// We use SemVer, and these versions are about the API, and
// may not necessarily match the ABI versions. Right now at
// version 0, you should not be making any forward compatibility
// assumptions.
const
  NNG_MAJOR_VERSION = 1;
  NNG_MINOR_VERSION = 3;
  NNG_PATCH_VERSION = 0;
  NNG_RELEASE_SUFFIX = ''; // if non-empty, this is a pre-release

// Maximum length of a socket address. This includes the terminating NUL.
// This limit is built into other implementations, so do not change it.
// Note that some transports are quite happy to let you use addresses
// in excess of this, but if you do you may not be able to communicate
// with other implementations.
  NNG_MAXADDRLEN = 128;

// Some definitions for durations used with timeouts.
const
  NNG_DURATION_INFINITE = -1;
  NNG_DURATION_DEFAULT  = -2;
  NNG_DURATION_ZERO     = 0;

// Options.
const
  NNG_OPT_SOCKNAME = 'socket-name';
  NNG_OPT_RAW = 'raw';
  NNG_OPT_PROTO = 'protocol';
  NNG_OPT_PROTONAME = 'protocol-name';
  NNG_OPT_PEER = 'peer';
  NNG_OPT_PEERNAME = 'peer-name';
  NNG_OPT_RECVBUF = 'recv-buffer';
  NNG_OPT_SENDBUF = 'send-buffer';
  NNG_OPT_RECVFD = 'recv-fd';
  NNG_OPT_SENDFD = 'send-fd';
  NNG_OPT_RECVTIMEO = 'recv-timeout';
  NNG_OPT_SENDTIMEO = 'send-timeout';
  NNG_OPT_LOCADDR = 'local-address';
  NNG_OPT_REMADDR = 'remote-address';
  NNG_OPT_URL = 'url';
  NNG_OPT_MAXTTL = 'ttl-max';
  NNG_OPT_RECVMAXSZ = 'recv-size-max';
  NNG_OPT_RECONNMINT = 'reconnect-time-min';
  NNG_OPT_RECONNMAXT = 'reconnect-time-max';

// TLS options are only used when the underlying transport supports TLS.

// NNG_OPT_TLS_CONFIG is a pointer to an nng_tls_config object.  Generally
// this can used with endpoints, although once an endpoint is started, or
// once a configuration is used, the value becomes read-only. Note that
// when configuring the object, a hold is placed on the TLS configuration,
// using a reference count.  When retrieving the object, no such hold is
// placed, and so the caller must take care not to use the associated object
// after the endpoint it is associated with is closed.
  NNG_OPT_TLS_CONFIG = 'tls-config';

// NNG_OPT_TLS_AUTH_MODE is a write-only integer (int) option that specifies
// whether peer authentication is needed.  The option can take one of the
// values of NNG_TLS_AUTH_MODE_NONE, NNG_TLS_AUTH_MODE_OPTIONAL, or
// NNG_TLS_AUTH_MODE_REQUIRED.  The default is typically NNG_TLS_AUTH_MODE_NONE
// for listeners, and NNG_TLS_AUTH_MODE_REQUIRED for dialers. If set to
// REQUIRED, then connections will be rejected if the peer cannot be verified.
// If set to OPTIONAL, then a verification step takes place, but the connection
// is still permitted.  (The result can be checked with NNG_OPT_TLS_VERIFIED).
  NNG_OPT_TLS_AUTH_MODE = 'tls-authmode';

// NNG_OPT_TLS_CERT_KEY_FILE names a single file that contains a certificate
// and key identifying the endpoint.  This is a write-only value.  This can be
// set multiple times for times for different keys/certs corresponding to
// different algorithms on listeners, whereas dialers only support one.  The
// file must contain both cert and key as PEM blocks, and the key must
// not be encrypted.  (If more flexibility is needed, use the TLS configuration
// directly, via NNG_OPT_TLS_CONFIG.)
  NNG_OPT_TLS_CERT_KEY_FILE = 'tls-cert-key-file';

// NNG_OPT_TLS_CA_FILE names a single file that contains certificate(s) for a
// CA, and optionally CRLs, which are used to validate the peer's certificate.
// This is a write-only value, but multiple CAs can be loaded by setting this
// multiple times.
  NNG_OPT_TLS_CA_FILE = 'tls-ca-file';

// NNG_OPT_TLS_SERVER_NAME is a write-only string that can typically be
// set on dialers to check the CN of the server for a match.  This
// can also affect SNI (server name indication).  It usually has no effect
// on listeners.
  NNG_OPT_TLS_SERVER_NAME = 'tls-server-name';

// NNG_OPT_TLS_VERIFIED returns a boolean indicating whether the peer has
// been verified (true) or not (false). Typically this is read-only, and
// only available for pipes. This option may return incorrect results if
// peer authentication is disabled with `NNG_TLS_AUTH_MODE_NONE`.
  NNG_OPT_TLS_VERIFIED = 'tls-verified';

// TCP options.  These may be supported on various transports that use
// TCP underneath such as TLS, or not.

// TCP nodelay disables the use of Nagle, so that messages are sent
// as soon as data is available. This tends to reduce latency, but
// can come at the cost of extra messages being sent, and may have
// a detrimental effect on performance. For most uses, we recommend
// enabling this. (Disable it if you are on a very slow network.)
// This is a boolean.
  NNG_OPT_TCP_NODELAY = 'tcp-nodelay';

// TCP keepalive causes the underlying transport to send keep-alive
// messages, and keep the session active. Keepalives are zero length
// messages with the ACK flag turned on. If we don't get an ACK back,
// then we know the other side is gone. This is useful for detecting
// dead peers, and is also used to prevent disconnections caused by
// middle boxes thinking the session has gone idle (e.g. keeping NAT
// state current). This is a boolean.
  NNG_OPT_TCP_KEEPALIVE = 'tcp-keepalive';

// Local TCP port number.  This is used on a listener, and is intended
// to be used after starting the listener in combination with a wildcard
// (0) local port.  This determines the actual ephemeral port that was
// selected and bound.  The value is provided as an int, but only the
// low order 16 bits will be set.  This is provided in native byte order,
// which makes it more convenient than using the NNG_OPT_LOCADDR option.
  NNG_OPT_TCP_BOUND_PORT = 'tcp-bound-port';

// IPC options.  These will largely vary depending on the platform,
// as POSIX systems have very different options than Windows.

// Security Descriptor.  This option may only be set on listeners
// on the Windows platform, where the object is a pointer to a
// a Windows SECURITY_DESCRIPTOR.
  NNG_OPT_IPC_SECURITY_DESCRIPTOR = 'ipc:security-descriptor';

// Permissions bits.  This option is only valid for listeners on
// POSIX platforms and others that honor UNIX style permission bits.
// Note that some platforms may not honor the permissions here, although
// at least Linux and macOS seem to do so.  Check before you rely on
// this for security.
  NNG_OPT_IPC_PERMISSIONS = 'ipc:permissions';

// Peer UID.  This is only available on POSIX style systems.
  NNG_OPT_IPC_PEER_UID = 'ipc:peer-uid';

// Peer GID (primary group).  This is only available on POSIX style systems.
  NNG_OPT_IPC_PEER_GID = 'ipc:peer-gid';

// Peer process ID.  Available on Windows, Linux, and SunOS.
// In theory we could obtain this with the first message sent,
// but we have elected not to do this for now. (Nice RFE for a FreeBSD
// guru though.)
  NNG_OPT_IPC_PEER_PID = 'ipc:peer-pid';

// Peer Zone ID.  Only on SunOS systems.  (Linux containers have no
// definable kernel identity; they are a user-land fabrication made up
// from various pieces of different namespaces. FreeBSD does have
// something called JailIDs, but it isn't obvious how to determine this,
// or even if processes can use IPC across jail boundaries.)
  NNG_OPT_IPC_PEER_ZONEID = 'ipc:peer-zoneid';

// WebSocket Options.

// NNG_OPT_WS_REQUEST_HEADERS is a string containing the
// request headers, formatted as CRLF terminated lines.
  NNG_OPT_WS_REQUEST_HEADERS = 'ws:request-headers';

// NNG_OPT_WS_RESPONSE_HEADERS is a string containing the
// response headers, formatted as CRLF terminated lines.
  NNG_OPT_WS_RESPONSE_HEADERS = 'ws:response-headers';

// NNG_OPT_WS_REQUEST_HEADER is a prefix, for a dynamic
// property name.  This allows direct access to any named header.
// Concatenate this with the name of the property (case is not sensitive).
// Only the first such header is returned.
  NNG_OPT_WS_RESPONSE_HEADER = 'ws:response-header:';

// NNG_OPT_WS_RESPONSE_HEADER is like NNG_OPT_REQUEST_HEADER, but used for
// accessing the request headers.
  NNG_OPT_WS_REQUEST_HEADER = 'ws:request-header:';

// NNG_OPT_WS_REQUEST_URI is used to obtain the URI sent by the client.
// This can be useful when a handler supports an entire directory tree.
  NNG_OPT_WS_REQUEST_URI = 'ws:request-uri';

// NNG_OPT_WS_SENDMAXFRAME is used to configure the fragmentation size
// used for frames.  This has a default value of 64k.  Large values
// are good for throughput, but penalize latency.  They also require
// additional buffering on the peer.  This value must not be larger
// than what the peer will accept, and unfortunately there is no way
// to negotiate this.
  NNG_OPT_WS_SENDMAXFRAME = 'ws:txframe-max';

// NNG_OPT_WS_RECVMAXFRAME is the largest frame we will accept.  This should
// probably not be larger than NNG_OPT_RECVMAXSZ. If the sender attempts
// to send more data than this in a single message, it will be dropped.
  NNG_OPT_WS_RECVMAXFRAME = 'ws:rxframe-max';

// NNG_OPT_WS_PROTOCOL is the "websocket subprotocol" -- it's a string.
// This is also known as the Sec-WebSocket-Protocol header. It is treated
// specially.  This is part of the websocket handshake.
  NNG_OPT_WS_PROTOCOL = 'ws:protocol';

implementation

end.
