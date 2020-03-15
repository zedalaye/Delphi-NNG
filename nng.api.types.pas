unit nng.api.types;

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
  nng.api.constants;

// Types common to nng.

// Identifiers are wrapped in a structure to improve compiler validation
// of incorrect passing.  This gives us strong type checking.  Modern
// compilers compile passing these by value to identical code as passing
// the integer type (at least with optimization applied).  Please do not
// access the ID member directly.

type
  Pnng_ctx = ^Tnng_ctx;
  Tnng_ctx = record
  	id: Cardinal;
  end;

  Pnng_dialer = ^Tnng_dialer;
  Tnng_dialer = record
	  id: Cardinal;
  end;

  Pnng_listener = ^Tnng_listener;
  Tnng_listener = record
	  id: Cardinal;
  end;

  Pnng_pipe = ^Tnng_pipe;
  Tnng_pipe = record
	  id: Cardinal;
  end;

  Pnng_socket = ^Tnng_socket;
  Tnng_socket = record
	  id: Cardinal;
  end;

  Tnng_duration = Integer; // in milliseconds

  Pnng_msg = ^Tnng_msg;
  Tnng_msg = record
  end;

  Pnng_stat = ^Tnng_stat;
  Tnng_stat = record
  end;

  Pnng_aio = ^Tnng_aio;
  Tnng_aio = record
  end;

// Initializers.
// clang-format off
//#define NNG_PIPE_INITIALIZER { 0 }
//#define NNG_SOCKET_INITIALIZER { 0 }
//#define NNG_DIALER_INITIALIZER { 0 }
//#define NNG_LISTENER_INITIALIZER { 0 }
//#define NNG_CTX_INITIALIZER { 0 }
// clang-format on

// Some address details. This is in some ways like a traditional sockets
// sockaddr, but we have our own to cope with our unique families, etc.
// The details of this structure are directly exposed to applications.
// These structures can be obtained via property lookups, etc.
  Pnng_sockaddr_inproc = ^Tnng_sockaddr_inproc;
  Tnng_sockaddr_inproc = record
    sa_family: Word;
    sa_name: array[0..NNG_MAXADDRLEN - 1] of AnsiChar;
  end;

  Pnng_sockaddr_path = ^Tnng_sockaddr_path;
  Tnng_sockaddr_path = record
    sa_family: Word;
    sa_path: array[0..NNG_MAXADDRLEN - 1] of AnsiChar;
  end;

  Pnng_sockaddr_ipc = ^Tnng_sockaddr_ipc;
  Tnng_sockaddr_ipc = Tnng_sockaddr_path;

  Pnng_sockaddr_in6 = ^Tnng_sockaddr_in6;
  Tnng_sockaddr_in6 = record
    sa_family: Word;
    sa_port: Word;
    sa_addr: array[0..16 - 1] of Byte;
  end;

  Pnng_sockaddr_udp6 = ^Tnng_sockaddr_udp6;
  Tnng_sockaddr_udp6 = Tnng_sockaddr_in6;

  Pnng_sockaddr_tcp6 = ^Tnng_sockaddr_tcp6;
  Tnng_sockaddr_tcp6 = Tnng_sockaddr_in6;

  Pnng_sockaddr_in = ^Tnng_sockaddr_in;
  Tnng_sockaddr_in = record
    sa_family: Word;
    sa_port: Word;
    sa_addr: Cardinal;
  end;

  Pnng_sockaddr_zt = ^Tnng_sockaddr_zt;
  Tnng_sockaddr_zt = record
    sa_family: Word;
    sa_nwid: UInt64;
    sa_nodeid: UInt64;
    sa_port: Cardinal;
  end;

  Pnng_sockaddr_udp = ^Tnng_sockaddr_udp;
  Tnng_sockaddr_udp = Tnng_sockaddr_in;

  Pnng_sockaddr_tcp = ^Tnng_sockaddr_tcp;
  Tnng_sockaddr_tcp = Tnng_sockaddr_in;

  Pnng_sockaddr = ^Tnng_sockaddr;
  Tnng_sockaddr = record
  case Byte of
    0: (s_family: Word);
    1: (s_ipc:    Tnng_sockaddr_ipc);
    2: (s_inproc: Tnng_sockaddr_inproc);
    3: (s_in6:    Tnng_sockaddr_in6);
    4: (s_in:     Tnng_sockaddr_in);
    5: (s_zt:     Tnng_sockaddr_zt);
  end;

  Tnng_sockaddr_family = (
  	NNG_AF_UNSPEC = 0,
    NNG_AF_INPROC = 1,
    NNG_AF_IPC    = 2,
    NNG_AF_INET   = 3,
    NNG_AF_INET6  = 4,
    NNG_AF_ZT     = 5 // ZeroTier
  );

// Scatter/gather I/O.
  Pnng_iov = ^Tnng_iov;
  Tnng_iov = record
    iov_buf: Pointer;
    iov_len: NativeUInt;
  end;

// Flags.
  Tnng_flag_enum = (
	  NNG_FLAG_ALLOC    = 1, // Recv to allocate receive buffer.
	  NNG_FLAG_NONBLOCK = 2  // Non-blocking operations.
  );

type
  Pnng_tls_config = ^Tnng_tls_config;
  Tnng_tls_config = record
  end;

  Tnng_tls_mode = (
    NNG_TLS_MODE_CLIENT = 0,
    NNG_TLS_MODE_SERVER = 1
  );

  Tnng_tls_auth_mode = (
    NNG_TLS_AUTH_MODE_NONE     = 0, // No verification is performed
    NNG_TLS_AUTH_MODE_OPTIONAL = 1, // Verify cert if presented
    NNG_TLS_AUTH_MODE_REQUIRED = 2  // Verify cert, close if invalid
  );

// TLS version numbers.  We encode the major number and minor number
// as separate byte fields.  No support for SSL 3.0 or earlier -- older
// versions are known to be insecure and should not be used.
// When possible applications should restrict themselves to TLS 1.2 or better.
  Tnng_tls_version = (
    NNG_TLS_1_0 = $301,
    NNG_TLS_1_1 = $302,
    NNG_TLS_1_2 = $303,
    NNG_TLS_1_3 = $304
  );

  Tnng_stat_type_enum = (
    NNG_STAT_SCOPE   = 0, // Stat is for scoping, and carries no value
    NNG_STAT_LEVEL   = 1, // Numeric "absolute" value, diffs meaningless
    NNG_STAT_COUNTER = 2, // Incrementing value (diffs are meaningful)
    NNG_STAT_STR     = 3, // Value is a string
    NNG_STAT_BOOLEAN = 4, // Value is a boolean
    NNG_STAT_ID      = 5  // Value is a numeric ID
  );

  Tnng_unit_enum = (
    NNG_UNIT_NONE     = 0, // No special units
    NNG_UNIT_BYTES    = 1, // Bytes, e.g. bytes sent, etc.
    NNG_UNIT_MESSAGES = 2, // Messages, one per message
    NNG_UNIT_MILLIS   = 3, // Milliseconds
    NNG_UNIT_EVENTS   = 4  // Some other type of event
  );

  Tnng_errno_enum = (
    NNG_EINTR        = 1,
    NNG_ENOMEM       = 2,
    NNG_EINVAL       = 3,
    NNG_EBUSY        = 4,
    NNG_ETIMEDOUT    = 5,
    NNG_ECONNREFUSED = 6,
    NNG_ECLOSED      = 7,
    NNG_EAGAIN       = 8,
    NNG_ENOTSUP      = 9,
    NNG_EADDRINUSE   = 10,
    NNG_ESTATE       = 11,
    NNG_ENOENT       = 12,
    NNG_EPROTO       = 13,
    NNG_EUNREACHABLE = 14,
    NNG_EADDRINVAL   = 15,
    NNG_EPERM        = 16,
    NNG_EMSGSIZE     = 17,
    NNG_ECONNABORTED = 18,
    NNG_ECONNRESET   = 19,
    NNG_ECANCELED    = 20,
    NNG_ENOFILES     = 21,
    NNG_ENOSPC       = 22,
    NNG_EEXIST       = 23,
    NNG_EREADONLY    = 24,
    NNG_EWRITEONLY   = 25,
    NNG_ECRYPTO      = 26,
    NNG_EPEERAUTH    = 27,
    NNG_ENOARG       = 28,
    NNG_EAMBIGUOUS   = 29,
    NNG_EBADTYPE     = 30,
    NNG_ECONNSHUT    = 31,
    NNG_EINTERNAL    = 1000,
    NNG_ESYSERR      = $10000000,
    NNG_ETRANERR     = $20000000
  );

  Pnng_url = ^Tnng_url;
  Tnng_url = record
    u_rawurl: PAnsiChar;   // never NULL
    u_scheme: PAnsiChar;   // never NULL
    u_userinfo: PAnsiChar; // will be NULL if not specified
    u_host: PAnsiChar;     // including colon and port
    u_hostname: PAnsiChar; // name only, will be "" if not specified
    u_port: PAnsiChar;     // port, will be "" if not specified
    u_path: PAnsiChar;     // path, will be "" if not specified
    u_query: PAnsiChar;    // without '?', will be NULL if not specified
    u_fragment: PAnsiChar; // without '#', will be NULL if not specified
    u_requri: PAnsiChar;   // includes query and fragment, "" if not specified
  end;

  Pnng_stream = ^Tnng_stream;
  Tnng_stream = record
  end;

  Pnng_stream_dialer = ^Tnng_stream_dialer;
  Tnng_stream_dialer = record
  end;

  Pnng_stream_listener = ^Tnng_stream_listener;
  Tnng_stream_listener = record
  end;

type
  Pnng_optspec = ^Tnng_optspec;
  Tnng_optspec = record
    o_name: PAnsiChar;  // Long style name (may be NULL for short only)
    o_short: Integer;   // Short option (no clustering!)
    o_val: Integer;     // Value stored on a good parse (>0)
    o_arg: Boolean;     // Option takes an argument if true
  end;

// HTTP status codes.  This list is not exhaustive.
type
  Tnng_http_status = (
    NNG_HTTP_STATUS_CONTINUE                 = 100,
    NNG_HTTP_STATUS_SWITCHING                = 101,
    NNG_HTTP_STATUS_PROCESSING               = 102,
    NNG_HTTP_STATUS_OK                       = 200,
    NNG_HTTP_STATUS_CREATED                  = 201,
    NNG_HTTP_STATUS_ACCEPTED                 = 202,
    NNG_HTTP_STATUS_NOT_AUTHORITATIVE        = 203,
    NNG_HTTP_STATUS_NO_CONTENT               = 204,
    NNG_HTTP_STATUS_RESET_CONTENT            = 205,
    NNG_HTTP_STATUS_PARTIAL_CONTENT          = 206,
    NNG_HTTP_STATUS_MULTI_STATUS             = 207,
    NNG_HTTP_STATUS_ALREADY_REPORTED         = 208,
    NNG_HTTP_STATUS_IM_USED                  = 226,
    NNG_HTTP_STATUS_MULTIPLE_CHOICES         = 300,
    NNG_HTTP_STATUS_STATUS_MOVED_PERMANENTLY = 301,
    NNG_HTTP_STATUS_FOUND                    = 302,
    NNG_HTTP_STATUS_SEE_OTHER                = 303,
    NNG_HTTP_STATUS_NOT_MODIFIED             = 304,
    NNG_HTTP_STATUS_USE_PROXY                = 305,
    NNG_HTTP_STATUS_TEMPORARY_REDIRECT       = 307,
    NNG_HTTP_STATUS_PERMANENT_REDIRECT       = 308,
    NNG_HTTP_STATUS_BAD_REQUEST              = 400,
    NNG_HTTP_STATUS_UNAUTHORIZED             = 401,
    NNG_HTTP_STATUS_PAYMENT_REQUIRED         = 402,
    NNG_HTTP_STATUS_FORBIDDEN                = 403,
    NNG_HTTP_STATUS_NOT_FOUND                = 404,
    NNG_HTTP_STATUS_METHOD_NOT_ALLOWED       = 405,
    NNG_HTTP_STATUS_NOT_ACCEPTABLE           = 406,
    NNG_HTTP_STATUS_PROXY_AUTH_REQUIRED      = 407,
    NNG_HTTP_STATUS_REQUEST_TIMEOUT          = 408,
    NNG_HTTP_STATUS_CONFLICT                 = 409,
    NNG_HTTP_STATUS_GONE                     = 410,
    NNG_HTTP_STATUS_LENGTH_REQUIRED          = 411,
    NNG_HTTP_STATUS_PRECONDITION_FAILED      = 412,
    NNG_HTTP_STATUS_PAYLOAD_TOO_LARGE        = 413,
    NNG_HTTP_STATUS_ENTITY_TOO_LONG          = 414,
    NNG_HTTP_STATUS_UNSUPPORTED_MEDIA_TYPE   = 415,
    NNG_HTTP_STATUS_RANGE_NOT_SATISFIABLE    = 416,
    NNG_HTTP_STATUS_EXPECTATION_FAILED       = 417,
    NNG_HTTP_STATUS_TEAPOT                   = 418,
    NNG_HTTP_STATUS_UNPROCESSABLE_ENTITY     = 422,
    NNG_HTTP_STATUS_LOCKED                   = 423,
    NNG_HTTP_STATUS_FAILED_DEPENDENCY        = 424,
    NNG_HTTP_STATUS_UPGRADE_REQUIRED         = 426,
    NNG_HTTP_STATUS_PRECONDITION_REQUIRED    = 428,
    NNG_HTTP_STATUS_TOO_MANY_REQUESTS        = 429,
    NNG_HTTP_STATUS_HEADERS_TOO_LARGE        = 431,
    NNG_HTTP_STATUS_UNAVAIL_LEGAL_REASONS    = 451,
    NNG_HTTP_STATUS_INTERNAL_SERVER_ERROR    = 500,
    NNG_HTTP_STATUS_NOT_IMPLEMENTED          = 501,
    NNG_HTTP_STATUS_BAD_GATEWAY              = 502,
    NNG_HTTP_STATUS_SERVICE_UNAVAILABLE      = 503,
    NNG_HTTP_STATUS_GATEWAY_TIMEOUT          = 504,
    NNG_HTTP_STATUS_HTTP_VERSION_NOT_SUPP    = 505,
    NNG_HTTP_STATUS_VARIANT_ALSO_NEGOTIATES  = 506,
    NNG_HTTP_STATUS_INSUFFICIENT_STORAGE     = 507,
    NNG_HTTP_STATUS_LOOP_DETECTED            = 508,
    NNG_HTTP_STATUS_NOT_EXTENDED             = 510,
    NNG_HTTP_STATUS_NETWORK_AUTH_REQUIRED    = 511
  );

// nng_http_req represents an HTTP request.
  Pnng_http_req = ^Tnng_http_req;
  Tnng_http_req = record
  end;

// nng_http_res represents an HTTP response.
  Pnng_http_res = ^Tnng_http_res;
  Tnng_http_res = record
  end;

// An nng_http_conn represents an underlying "connection".  It may be
// a TCP channel, or a TLS channel, but the main thing is that this is
// normally only used for exchanging HTTP requests and responses.
  Pnng_http_conn = ^Tnng_http_conn;
  Tnng_http_conn = record
  end;

// nng_http_handler is a handler used on the server side to handle HTTP
// requests coming into a specific URL.
  Pnng_http_handler = ^Tnng_http_handler;
  Tnng_http_handler = record
  end;

// nng_http_server is a handle to an HTTP server instance.  Servers
// only serve a single port / address at this time.
  Pnng_http_server = ^Tnng_http_server;
  Tnng_http_server = record
  end;

// nng_http_client represents a "client" object.  Clients can be used
// to create HTTP connections.  At present, connections are not cached
// or reused, but that could change in the future.
  Pnng_http_client = ^Tnng_http_client;
  Tnng_http_client = record
  end;

implementation

end.
