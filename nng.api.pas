unit nng.api;

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

// NNG (nanomsg-next-gen) is an improved implementation of the SP protocols.
// The APIs have changed, and there is no attempt to provide API compatibility
// with legacy libnanomsg. This file defines the library consumer-facing
// Public API. Use of definitions or declarations not found in this header
// file is specifically unsupported and strongly discouraged.

interface

uses
  nng.api.types,
  nng.api.constants;

// NNG_PROTOCOL_NUMBER is used by protocol headers to calculate their
// protocol number from a major and minor number.  Applications should
// probably not need to use this.
//  #define NNG_PROTOCOL_NUMBER(maj, min) (((x) *16) + (y))

// nng_fini is used to terminate the library, freeing certain global resources.
// This should only be called during atexit() or just before dlclose().
// THIS FUNCTION MUST NOT BE CALLED CONCURRENTLY WITH ANY OTHER FUNCTION
// IN THIS LIBRARY; IT IS NOT REENTRANT OR THREADSAFE.
//
// For most cases, this call is unnecessary, but it is provided to assist
// when debugging with memory checkers (e.g. valgrind).  Calling this
// function prevents global library resources from being reported incorrectly
// as memory leaks.  In those cases, we recommend doing this with atexit().
procedure nng_fini; cdecl; external NNG_LIB;

// nng_close closes the socket, terminating all activity and
// closing any underlying connections and releasing any associated
// resources.
function nng_close(s: Tnng_socket): Integer; cdecl; external NNG_LIB;

// nng_socket_id returns the positive socket id for the socket, or -1
// if the socket is not valid.
function nng_socket_id(s: Tnng_socket): Integer; cdecl; external NNG_LIB;

// nng_closeall closes all open sockets. Do not call this from
// a library; it will affect all sockets.
procedure nng_closeall; cdecl; external NNG_LIB;

// nng_setopt sets an option for a specific socket.
function nng_setopt(s: Tnng_socket; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_setopt_bool(s: Tnng_socket; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_setopt_int(s: Tnng_socket; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_setopt_ms(s: Tnng_socket; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_setopt_size(s: Tnng_socket; const name: PAnsiChar; val: NativeUint): Integer; cdecl; external NNG_LIB;
function nng_setopt_uint64(s: Tnng_socket; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_setopt_string(s: Tnng_socket; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_setopt_ptr(s: Tnng_socket; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;

// nng_socket_getopt obtains the option for a socket.
function nng_getopt(s: Tnng_socket; const name: PAnsiChar; val: Pointer; var size: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_getopt_bool(s: Tnng_socket; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_getopt_int(s: Tnng_socket; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_getopt_ms(s: Tnng_socket; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_getopt_size(s: Tnng_socket; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_getopt_uint64(s: Tnng_socket; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_getopt_ptr(s: Tnng_socket; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;

// nng_getopt_string is special -- it allocates a string to hold the
// resulting string, which should be freed with nng_strfree when it is
// no logner needed.
function nng_getopt_string(s: Tnng_socket; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;

function nng_socket_set(s: Tnng_socket; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_socket_set_bool(s: Tnng_socket; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_socket_set_int(s: Tnng_socket; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_socket_set_size(s: Tnng_socket; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_socket_set_uint64(s: Tnng_socket; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_socket_set_string(s: Tnng_socket; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_socket_set_ptr(s: Tnng_socket; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_socket_set_ms(s: Tnng_socket; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_socket_set_addr(s: Tnng_socket; const name: PAnsiChar; const addr: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

function nng_socket_get(s: Tnng_socket; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_socket_get_bool(s: Tnng_socket; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_socket_get_int(s: Tnng_socket; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_socket_get_size(s: Tnng_socket; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_socket_get_uint64(s: Tnng_socket; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_socket_get_string(s: Tnng_socket; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_socket_get_ptr(s: Tnng_socket; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_socket_get_ms(s: Tnng_socket; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_socket_get_addr(s: Tnng_socket; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

// Arguably the pipe callback functions could be handled as an option,
// but with the need to specify an argument, we find it best to unify
// this as a separate function to pass in the argument and the callback.
// Only one callback can be set on a given socket, and there is no way
// to retrieve the old value.
type
  Tnng_pipe_ev = (
    NNG_PIPE_EV_ADD_PRE,  // Called just before pipe added to socket
    NNG_PIPE_EV_ADD_POST, // Called just after pipe added to socket
    NNG_PIPE_EV_REM_POST, // Called just after pipe removed from socket
    NNG_PIPE_EV_NUM       // Used internally, must be last.
  );

Tnng_pipe_cb = procedure(pipe: Tnng_pipe; ev: Tnng_pipe_ev; arg: Pointer); cdecl;


// nng_pipe_notify registers a callback to be executed when the
// given event is triggered.  To watch for different events, register
// multiple times.  Each event can have at most one callback registered.
function nng_pipe_notify(s: Tnng_socket; ev: Tnng_pipe_ev; cb: Tnng_pipe_cb; arg: Pointer): Integer; cdecl; external NNG_LIB;

// nng_listen creates a listening endpoint with no special options,
// and starts it listening.  It is functionally equivalent to the legacy
// nn_bind(). The underlying endpoint is returned back to the caller in the
// endpoint pointer, if it is not NULL.  The flags are ignored at present.
function nng_listen(s: Tnng_socket; const addr: PAnsiChar; lg: Pnng_listener; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_dial creates a dialing endpoint, with no special options, and
// starts it dialing.  Dialers have at most one active connection at a time
// This is similar to the legacy nn_connect().  The underlying endpoint
// is returned back to the caller in the endpoint pointer, if it is not NULL.
// The flags may be NNG_FLAG_NONBLOCK to indicate that the first attempt to
// dial will be made in the background, returning control to the caller
// immediately.  In this case, if the connection fails, the function will
// keep retrying in the background.  (If the connection is dropped in either
// case, it will still be reconnected in the background -- only the initial
// connection attempt is normally synchronous.)
function nng_dial(s: Tnng_socket; const addr: PAnsiChar; dp: Pnng_dialer; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_dialer_create creates a new dialer, that is not yet started.
function nng_dialer_create(dp: Pnng_dialer; s: Tnng_socket; const addr: PAnsiChar): Integer; cdecl; external NNG_LIB;

// nng_listener_create creates a new listener, that is not yet started.
function nng_listener_create(lp: Pnng_listener; s: Tnng_socket; const addr: PAnsiChar): Integer; cdecl; external NNG_LIB;

// nng_dialer_start starts the endpoint dialing.  This is only possible if
// the dialer is not already dialing.
function nng_dialer_start(d: Tnng_dialer; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_listener_start starts the endpoint listening.  This is only possible if
// the listener is not already listening.
function nng_listener_start(l: Tnng_listener; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_dialer_close closes the dialer, shutting down all underlying
// connections and releasing all associated resources.
function nng_dialer_close(d: Tnng_dialer): Integer; cdecl; external NNG_LIB;

// nng_listener_close closes the listener, shutting down all underlying
// connections and releasing all associated resources.
function nng_listener_close(l: Tnng_listener): Integer; cdecl; external NNG_LIB;

// nng_dialer_id returns the positive dialer ID, or -1 if the dialer is
// invalid.
function nng_dialer_id(d: Tnng_dialer): Integer; cdecl; external NNG_LIB;

// nng_listener_id returns the positive listener ID, or -1 if the listener is
// invalid.
function nng_listener_id(l: Tnng_listener): Integer; cdecl; external NNG_LIB;

// nng_dialer_setopt sets an option for a specific dialer.  Note
// dialer options may not be altered on a running dialer.
function nng_dialer_setopt(d: Tnng_dialer; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_setopt_bool(d: Tnng_dialer; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_dialer_setopt_int(d: Tnng_dialer; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_dialer_setopt_ms(d: Tnng_dialer; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_dialer_setopt_size(d: Tnng_dialer; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_setopt_uint64(d: Tnng_dialer; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_dialer_setopt_ptr(d: Tnng_dialer; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_dialer_setopt_string(d: Tnng_dialer; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;

// nng_dialer_getopt obtains the option for a dialer. This will
// fail for options that a particular dialer is not interested in,
// even if they were set on the socket.
function nng_dialer_getopt(d: Tnng_dialer; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_getopt_bool(d: Tnng_dialer; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_dialer_getopt_int(d: Tnng_dialer; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_dialer_getopt_ms(d: Tnng_dialer; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_dialer_getopt_size(d: Tnng_dialer; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_getopt_sockaddr(d: Tnng_dialer; const name: PAnsiChar; var val: Tnng_sockaddr): Integer; cdecl; external NNG_LIB;
function nng_dialer_getopt_uint64(d: Tnng_dialer; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_dialer_getopt_ptr(d: Tnng_dialer; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;

// nng_dialer_getopt_string is special -- it allocates a string to hold the
// resulting string, which should be freed with nng_strfree when it is
// no logner needed.
function nng_dialer_getopt_string(d: Tnng_dialer; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;

function nng_dialer_set(d: Tnng_dialer; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_bool(d: Tnng_dialer; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_int(d: Tnng_dialer; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_size(d: Tnng_dialer; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_uint64(d: Tnng_dialer; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_string(d: Tnng_dialer; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_ptr(d: Tnng_dialer; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_ms(d: Tnng_dialer; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_dialer_set_addr(d: Tnng_dialer; const name: PAnsiChar; const val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

function nng_dialer_get(d: Tnng_dialer; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_bool(d: Tnng_dialer; const charname: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_int(d: Tnng_dialer; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_size(d: Tnng_dialer; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_uint64(d: Tnng_dialer; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_string(d: Tnng_dialer; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_ptr(d: Tnng_dialer; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_ms(d: Tnng_dialer; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_dialer_get_addr(d: Tnng_dialer; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

// nng_listener_setopt sets an option for a dialer.  This value is
// not stored in the socket.  Subsequent setopts on the socket may
// override these value however.  Note listener options may not be altered
// on a running listener.
function nng_listener_setopt(l: Tnng_listener; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_setopt_bool(l: Tnng_listener; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_listener_setopt_int(l: Tnng_listener; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_listener_setopt_ms(l: Tnng_listener; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_listener_setopt_size(l: Tnng_listener; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_setopt_uint64(l: Tnng_listener; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_listener_setopt_ptr(l: Tnng_listener; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_listener_setopt_string(l: Tnng_listener; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;

// nng_listener_getopt obtains the option for a listener.  This will
// fail for options that a particular listener is not interested in,
// even if they were set on the socket.
function nng_listener_getopt(l: Tnng_listener; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_getopt_bool(l: Tnng_listener; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_listener_getopt_int(l: Tnng_listener; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_listener_getopt_ms(l: Tnng_listener; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_listener_getopt_size(l: Tnng_listener; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_getopt_sockaddr(l: Tnng_listener; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;
function nng_listener_getopt_uint64(l: Tnng_listener; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_listener_getopt_ptr(l: Tnng_listener; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;

// nng_listener_getopt_string is special -- it allocates a string to hold the
// resulting string, which should be freed with nng_strfree when it is
// no logner needed.
function nng_listener_getopt_string(l: Tnng_listener; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;

function nng_listener_set(l: Tnng_listener; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_set_bool(l: Tnng_listener; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_listener_set_int(l: Tnng_listener; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_listener_set_size(l: Tnng_listener; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_set_uint64(l: Tnng_listener; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_listener_set_string(l: Tnng_listener; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_listener_set_ptr(l: Tnng_listener; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_listener_set_ms(l: Tnng_listener; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_listener_set_addr(nl: Tnng_listener; const name: PAnsiChar; const val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

function nng_listener_get(l: Tnng_listener; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_get_bool(l: Tnng_listener; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_listener_get_int(l: Tnng_listener; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_listener_get_size(l: Tnng_listener; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_listener_get_uint64(l: Tnng_listener; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_listener_get_string(l: Tnng_listener; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_listener_get_ptr(l: Tnng_listener; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_listener_get_ms(l: Tnng_listener; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_listener_get_addr(l: Tnng_listener; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

// nng_strerror returns a human readable string associated with the error
// code supplied.
function nng_strerror(num: Integer): PAnsiChar; cdecl; external NNG_LIB;

// nng_send sends (or arranges to send) the data on the socket.  Note that
// this function may (will!) return before any receiver has actually
// received the data.  The return value will be zero to indicate that the
// socket has accepted the entire data for send, or an errno to indicate
// failure.  The flags may include NNG_FLAG_NONBLOCK or NNG_FLAG_ALLOC.
// If the flag includes NNG_FLAG_ALLOC, then the function will call
// nng_free() on the supplied pointer & size on success. (If the call
// fails then the memory is not freed.)
function nng_send(s: Tnng_socket; buf: Pointer; len: NativeUInt; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_recv receives message data into the socket, up to the supplied size.
// The actual size of the message data will be written to the value pointed
// to by size.  The flags may include NNG_FLAG_NONBLOCK and NNG_FLAG_ALLOC.
// If NNG_FLAG_ALLOC is supplied then the library will allocate memory for
// the caller.  In that case the pointer to the allocated will be stored
// instead of the data itself.  The caller is responsible for freeing the
// associated memory with nng_free().
function nng_recv(s: Tnng_socket; buf: Pointer; var len: NativeUInt; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_sendmsg is like nng_send, but offers up a message structure, which
// gives the ability to provide more control over the message, including
// providing backtrace information.  It also can take a message that was
// obtain via nn_recvmsg, allowing for zero copy forwarding.
function nng_sendmsg(s: Tnng_socket; m: Pnng_msg; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_recvmsg is like nng_recv, but is used to obtain a message structure
// as well as the data buffer.  This can be used to obtain more information
// about where the message came from, access raw headers, etc.  It also
// can be passed off directly to nng_sendmsg.
function nng_recvmsg(s: Tnng_socket; var m: Pnng_msg; flags: Integer): Integer; cdecl; external NNG_LIB;

// nng_send_aio sends data on the socket asynchronously.  As with nng_send,
// the completion may be executed before the data has actually been delivered,
// but only when it is accepted for delivery.  The supplied AIO must have
// been initialized, and have an associated message.  The message will be
// "owned" by the socket if the operation completes successfully.  Otherwise
// the caller is responsible for freeing it.
procedure nng_send_aio(s: Tnng_socket; aio: Pnng_aio); cdecl; external NNG_LIB;

// nng_recv_aio receives data on the socket asynchronously.  On a successful
// result, the AIO will have an associated message, that can be obtained
// with nng_aio_get_msg().  The caller takes ownership of the message at
// this point.
procedure nng_recv_aio(s: Tnng_socket; aio: Pnng_aio); cdecl; external NNG_LIB;

// Context support.  User contexts are not supported by all protocols,
// but for those that do, they give a way to create multiple contexts
// on a single socket, each of which runs the protocol's state machinery
// independently, offering a way to achieve concurrent protocol support
// without resorting to raw mode sockets.  See the protocol specific
// documentation for further details.  (Note that at this time, only
// asynchronous send/recv are supported for contexts, but its easy enough
// to make synchronous versions with nng_aio_wait().)  Note that nng_close
// of the parent socket will *block* as long as any contexts are open.

// nng_ctx_open creates a context.  This returns NNG_ENOTSUP if the
// protocol implementation does not support separate contexts.
function nng_ctx_open(var c: Tnng_ctx; s: Tnng_socket): Integer; cdecl; external NNG_LIB;

// nng_ctx_close closes the context.
function nng_ctx_close(c: Tnng_ctx): Integer; cdecl; external NNG_LIB;

// nng_ctx_id returns the numeric id for the context; this will be
// a positive value for a valid context, or < 0 for an invalid context.
// A valid context is not necessarily an *open* context.
function nng_ctx_id(c: Tnng_ctx): Integer; cdecl; external NNG_LIB;

// nng_ctx_recv receives asynchronously.  It works like nng_recv_aio, but
// uses a local context instead of the socket global context.
procedure nng_ctx_recv(c: Tnng_ctx; aio: Pnng_aio); cdecl; external NNG_LIB;

// nng_ctx_send sends asynchronously. It works like nng_send_aio, but
// uses a local context instead of the socket global context.
procedure nng_ctx_send(c: Tnng_ctx; aio: Pnng_aio); cdecl; external NNG_LIB;

// nng_ctx_getopt is used to retrieve a context-specific option.  This
// can only be used for those options that relate to specific context
// tunables (which does include NNG_OPT_SENDTIMEO and NNG_OPT_RECVTIMEO);
// see the protocol documentation for more details.
function nng_ctx_getopt(c: Tnng_ctx; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_ctx_getopt_bool(c: Tnng_ctx; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_ctx_getopt_int(c: Tnng_ctx; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_ctx_getopt_ms(c: Tnng_ctx; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_ctx_getopt_size(c: Tnng_ctx; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;

// nng_ctx_setopt is used to set a context-specific option.  This
// can only be used for those options that relate to specific context
// tunables (which does include NNG_OPT_SENDTIMEO and NNG_OPT_RECVTIMEO);
// see the protocol documentation for more details.
function nng_ctx_setopt(c: Tnng_ctx; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_ctx_setopt_bool(c: Tnng_ctx; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_ctx_setopt_int(c: Tnng_ctx; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_ctx_setopt_ms(c: Tnng_ctx; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_ctx_setopt_size(c: Tnng_ctx; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;

function nng_ctx_get(c: Tnng_ctx; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_bool(c: Tnng_ctx; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_int(c: Tnng_ctx; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_size(c: Tnng_ctx; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_uint64(c: Tnng_ctx; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_string(c: Tnng_ctx; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_ptr(c: Tnng_ctx; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_ms(c: Tnng_ctx; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_ctx_get_addr(c: Tnng_ctx; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

function nng_ctx_set(c: Tnng_ctx; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_bool(c: Tnng_ctx; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_int(c: Tnng_ctx; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_size(c: Tnng_ctx; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_uint64(c: Tnng_ctx; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_string(c: Tnng_ctx; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_ptr(c: Tnng_ctx; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_ms(c: Tnng_ctx; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_ctx_set_addr(c: Tnng_ctx; const name: PAnsiChar; const val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

// nng_alloc is used to allocate memory.  It's intended purpose is for
// allocating memory suitable for message buffers with nng_send().
// Applications that need memory for other purposes should use their platform
// specific API.
function nng_alloc(sz: NativeUInt): Pointer; cdecl; external NNG_LIB;

// nng_free is used to free memory allocated with nng_alloc, which includes
// memory allocated by nng_recv() when the NNG_FLAG_ALLOC message is supplied.
// As the application is required to keep track of the size of memory, this
// is probably less convenient for general uses than the C library malloc and
// calloc.
procedure nng_free(ptr: Pointer; sz: NativeUInt); cdecl; external NNG_LIB;

// nng_strdup duplicates the source string, using nng_alloc. The result
// should be freed with nng_strfree (or nng_free(strlen(s)+1)).
function nng_strdup(const str: PAnsiChar): PAnsiChar; cdecl; external NNG_LIB;

// nng_strfree is equivalent to nng_free(strlen(s)+1).
procedure nng_strfree(str: PAnsiChar); cdecl; external NNG_LIB;

// Async IO API.  AIO structures can be thought of as "handles" to
// support asynchronous operations.  They contain the completion callback, and
// a pointer to consumer data.  This is similar to how overlapped I/O
// works in Windows, when used with a completion callback.
//
// AIO structures can carry up to 4 distinct input values, and up to
// 4 distinct output values, and up to 4 distinct "private state" values.
// The meaning of the inputs and the outputs are determined by the
// I/O functions being called.

// nng_aio_alloc allocates a new AIO, and associated the completion
// callback and its opaque argument.  If NULL is supplied for the
// callback, then the caller must use nng_aio_wait() to wait for the
// operation to complete.  If the completion callback is not NULL, then
// when a submitted operation completes (or is canceled or fails) the
// callback will be executed, generally in a different thread, with no
// locks held.
type
  Taio_alloc_cb = procedure(ptr: Pointer); cdecl;

function nng_aio_alloc(var aio: Pnng_aio; cb: Taio_alloc_cb; arg: Pointer): Integer; cdecl; external NNG_LIB;

// nng_aio_free frees the AIO and any associated resources.
// It *must not* be in use at the time it is freed.
procedure nng_aio_free(aio: Pnng_aio); cdecl; external NNG_LIB;

// nng_aio_stop stops any outstanding operation, and waits for the
// AIO to be free, including for the callback to have completed
// execution.  Therefore the caller must NOT hold any locks that
// are acquired in the callback, or deadlock will occur.
procedure nng_aio_stop(aio: Pnng_aio); cdecl; external NNG_LIB;

// nng_aio_result returns the status/result of the operation. This
// will be zero on successful completion, or an nng error code on
// failure.
function nng_aio_result(aio: Pnng_aio): Integer; cdecl; external NNG_LIB;

// nng_aio_count returns the number of bytes transferred for certain
// I/O operations.  This is meaningless for other operations (e.g.
// DNS lookups or TCP connection setup).
function nng_aio_count(aio: Pnng_aio): NativeUInt; cdecl; external NNG_LIB;

// nng_aio_cancel attempts to cancel any in-progress I/O operation.
// The AIO callback will still be executed, but if the cancellation is
// successful then the status will be NNG_ECANCELED.
procedure nng_aio_cancel(aio: Pnng_aio); cdecl; external NNG_LIB;

// nng_aio_abort is like nng_aio_cancel, but allows for a different
// error result to be returned.
procedure nng_aio_abort(aio: Pnng_aio; err_code: Integer); cdecl; external NNG_LIB;

// nng_aio_wait waits synchronously for any pending operation to complete.
// It also waits for the callback to have completed execution.  Therefore,
// the caller of this function must not hold any locks acquired by the
// callback or deadlock may occur.
procedure nng_aio_wait(aio: Pnng_aio); cdecl; external NNG_LIB;

// nng_aio_set_msg sets the message structure to use for asynchronous
// message send operations.
procedure nng_aio_set_msg(aio: Pnng_aio; msg: Pnng_msg); cdecl; external NNG_LIB;

// nng_aio_get_msg returns the message structure associated with a completed
// receive operation.
function nng_aio_get_msg(aio: Pnng_aio): Pnng_msg; cdecl; external NNG_LIB;

// nng_aio_set_input sets an input parameter at the given index.
function nng_aio_set_input(aio: Pnng_aio; index: Cardinal; arg: Pointer): Integer; cdecl; external NNG_LIB;

// nng_aio_get_input retrieves the input parameter at the given index.
function nng_aio_get_input(aio: Pnng_aio; index: Cardinal): Pointer; cdecl; external NNG_LIB;

// nng_aio_set_output sets an output result at the given index.
function nng_aio_set_output(aio: Pnng_aio; index: Cardinal; arg: Pointer): Integer; cdecl; external NNG_LIB;

// nng_aio_get_output retrieves the output result at the given index.
function nng_aio_get_output(aio: Pnng_aio; index: Cardinal): Pointer; cdecl; external NNG_LIB;

// nng_aio_set_timeout sets a timeout on the AIO.  This should be called for
// operations that should time out after a period.  The timeout should be
// either a positive number of milliseconds, or NNG_DURATION_INFINITE to
// indicate that the operation has no timeout.  A poll may be done by
// specifying NNG_DURATION_ZERO.  The value NNG_DURATION_DEFAULT indicates
// that any socket specific timeout should be used.
procedure nng_aio_set_timeout(aio: Pnng_aio; when: Tnng_duration); cdecl; external NNG_LIB;

// nng_aio_set_iov sets a scatter/gather vector on the aio.  The iov array
// itself is copied. Data members (the memory regions referenced) *may* be
// copied as well, depending on the operation.  This operation is guaranteed
// to succeed if n <= 4, otherwise it may fail due to NNG_ENOMEM.
function nng_aio_set_iov(aio: Pnng_aio; niov: Cardinal; const iov: Pnng_iov): Integer; cdecl; external NNG_LIB;

// nng_aio_begin is called by the provider to mark the operation as
// beginning.  If it returns false, then the provider must take no
// further action on the aio.
function nng_aio_begin(aio: Pnng_aio): Boolean; cdecl; external NNG_LIB;

// nng_aio_finish is used to "finish" an asynchronous operation.
// It should only be called by "providers" (such as HTTP server API users).
// The argument is the value that nng_aio_result() should return.
// IMPORTANT: Callers must ensure that this is called EXACTLY ONCE on any
// given aio.
procedure nng_aio_finish(aio: Pnng_aio; rv: Integer); cdecl; external NNG_LIB;

// nng_aio_defer is used to register a cancellation routine, and indicate
// that the operation will be completed asynchronously.  It must only be
// called once per operation on an aio, and must only be called by providers.
// If the operation is canceled by the consumer, the cancellation callback
// will be called.  The provider *must* still ensure that the nng_aio_finish()
// function is called EXACTLY ONCE.  If the operation cannot be canceled
// for any reason, the cancellation callback should do nothing.  The
// final argument is passed to the cancelfn.  The final argument of the
// cancellation function is the error number (will not be zero) corresponding
// to the reason for cancellation, e.g. NNG_ETIMEDOUT or NNG_ECANCELED.
type
  Tnng_aio_cancelfn = procedure(aio: Pnng_aio; arg: Pointer; flags: Integer); cdecl;

procedure nng_aio_defer(aio: Pnng_aio; cb: Tnng_aio_cancelfn; arg: Pointer); cdecl; external NNG_LIB;

// nng_aio_sleep does a "sleeping" operation, basically does nothing
// but wait for the specified number of milliseconds to expire, then
// calls the callback.  This returns 0, rather than NNG_ETIMEDOUT.
procedure nng_sleep_aio(ms: Tnng_duration; aio: Pnng_aio); cdecl; external NNG_LIB;

// Message API.
function nng_msg_alloc(var msg: Pnng_msg; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
procedure nng_msg_free(msg: Pnng_msg); cdecl; external NNG_LIB;
function nng_msg_realloc(msg: Pnng_msg; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_header(msg: Pnng_msg): Pointer; cdecl; external NNG_LIB;
function nng_msg_header_len(const msg: Pnng_msg): NativeUInt; cdecl; external NNG_LIB;
function nng_msg_body(msg: Pnng_msg): Pointer; cdecl; external NNG_LIB;
function nng_msg_len(const msg: Pnng_msg): NativeUInt; cdecl; external NNG_LIB;
function nng_msg_append(msg: Pnng_msg; const data: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_insert(msg: Pnng_msg; const data: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_trim(msg: Pnng_msg; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_chop(msg: Pnng_msg; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_header_append(msg: Pnng_msg; const data: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_header_insert(msg: Pnng_msg; const data: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_header_trim(msg: Pnng_msg; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_header_chop(msg: Pnng_msg; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_msg_header_append_u16(msg: Pnng_msg; data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_header_append_u32(msg: Pnng_msg; data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_header_append_u64(msg: Pnng_msg; data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_header_insert_u16(msg: Pnng_msg; data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_header_insert_u32(msg: Pnng_msg; data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_header_insert_u64(msg: Pnng_msg; data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_header_chop_u16(msg: Pnng_msg; var data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_header_chop_u32(msg: Pnng_msg; var data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_header_chop_u64(msg: Pnng_msg; var data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_header_trim_u16(msg: Pnng_msg; var data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_header_trim_u32(msg: Pnng_msg; var data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_header_trim_u64(msg: Pnng_msg; var data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_append_u16(msg: Pnng_msg; data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_append_u32(msg: Pnng_msg; data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_append_u64(msg: Pnng_msg; data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_insert_u16(msg: Pnng_msg; data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_insert_u32(msg: Pnng_msg; data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_insert_u64(msg: Pnng_msg; data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_chop_u16(msg: Pnng_msg; var data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_chop_u32(msg: Pnng_msg; var data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_chop_u64(msg: Pnng_msg; var data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_trim_u16(msg: Pnng_msg; var data: Word): Integer; cdecl; external NNG_LIB;
function nng_msg_trim_u32(msg: Pnng_msg; var data: Cardinal): Integer; cdecl; external NNG_LIB;
function nng_msg_trim_u64(msg: Pnng_msg; var data: UInt64): Integer; cdecl; external NNG_LIB;
function nng_msg_dup(var dup: Pnng_msg; const src: Pnng_msg): Integer; cdecl; external NNG_LIB;
procedure nng_msg_clear(msg: Pnng_msg); cdecl; external NNG_LIB;
procedure nng_msg_header_clear(msg: Pnng_msg); cdecl; external NNG_LIB;
procedure nng_msg_set_pipe(msg: Pnng_msg; pipe: Tnng_pipe); cdecl; external NNG_LIB;
function nng_msg_get_pipe(const msg: Pnng_msg): Pnng_pipe; cdecl; external NNG_LIB;

// nng_msg_getopt is defunct, and should not be used by programs. It
// always returns NNG_ENOTSUP.
function nng_msg_getopt(msg: Pnng_msg; opt: Integer; ptr: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB; deprecated;

// Pipe API. Generally pipes are only "observable" to applications, but
// we do permit an application to close a pipe. This can be useful, for
// example during a connection notification, to disconnect a pipe that
// is associated with an invalid or untrusted remote peer.
function nng_pipe_getopt(p: Tnng_pipe; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_bool(p: Tnng_pipe; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_int(p: Tnng_pipe; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_ms(p: Tnng_pipe; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_size(p: Tnng_pipe; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_sockaddr(p: Tnng_pipe; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_uint64(p: Tnng_pipe; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_ptr(p: Tnng_pipe; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_pipe_getopt_string(p: Tnng_pipe; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;

function nng_pipe_get(p: Tnng_pipe; const name: PAnsiChar; val: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_bool(p: Tnng_pipe; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_int(p: Tnng_pipe; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_ms(p: Tnng_pipe; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_size(p: Tnng_pipe; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_uint64(p: Tnng_pipe; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_string(p: Tnng_pipe; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_ptr(p: Tnng_pipe; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_pipe_get_addr(p: Tnng_pipe; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

function nng_pipe_close(p: Tnng_pipe): Integer; cdecl; external NNG_LIB;
function nng_pipe_id(p: Tnng_pipe): Integer; cdecl; external NNG_LIB;
function nng_pipe_socket(p: Tnng_pipe): Tnng_socket; cdecl; external NNG_LIB;
function nng_pipe_dialer(p: Tnng_pipe): Tnng_dialer; cdecl; external NNG_LIB;
function nng_pipe_listener(p: Tnng_pipe): Tnng_listener; cdecl; external NNG_LIB;

// XXX: TBD: priorities, ipv4only

// Statistics. These are for informational purposes only, and subject
// to change without notice. The API for accessing these is stable,
// but the individual statistic names, values, and meanings are all
// subject to change.

// nng_stats_get takes a snapshot of the entire set of statistics.
// While the operation can be somewhat expensive (allocations), it
// is done in a way that minimizes impact to running operations.
// Note that the statistics are provided as a tree, with parents
// used for grouping, and with child statistics underneath.  The
// top stat returned will be of type NNG_STAT_SCOPE with name "".
// Applications may choose to consider this root scope as "root", if
// the empty string is not suitable.
function nng_stats_get(var stat: Pnng_stat): Integer; cdecl; external NNG_LIB;

// nng_stats_free frees a previous list of snapshots.  This should only
// be called on the parent statistic that obtained via nng_stats_get.
procedure nng_stats_free(stat: Pnng_stat); cdecl; external NNG_LIB;

// nng_stats_dump is a debugging function that dumps the entire set of
// statistics to stdout.
procedure nng_stats_dump(stat: Pnng_stat); cdecl; external NNG_LIB;

// nng_stat_next finds the next sibling for the current stat.  If there
// are no more siblings, it returns NULL.
function nng_stat_next(stat: Pnng_stat): Pnng_stat; cdecl; external NNG_LIB;

// nng_stat_child finds the first child of the current stat.  If no children
// exist, then NULL is returned.
function nng_stat_child(stat: Pnng_stat): Pnng_stat; cdecl; external NNG_LIB;

// nng_stat_name is used to determine the name of the statistic.
// This is a human readable name.  Statistic names, as well as the presence
// or absence or semantic of any particular statistic are not part of any
// stable API, and may be changed without notice in future updates.
function nng_stat_name(stat: Pnng_stat): PAnsiChar; cdecl; external NNG_LIB;

// nng_stat_type is used to determine the type of the statistic.
// Counters generally increment, and therefore changes in the value over
// time are likely more interesting than the actual level.  Level
// values reflect some absolute state however, and should be presented to the
// user as is.
function nng_stat_type(stat: Pnng_stat): Integer; cdecl; external NNG_LIB;

// nng_stat_find is used to find a specific named statistic within
// a statistic tree.  NULL is returned if no such statistic exists.
function nng_stat_find(stat: Pnng_stat; const name: PAnsiChar): Pnng_stat; cdecl; external NNG_LIB;

// nng_stat_find_socket is used to find the stats for the given socket.
function nng_stat_find_socket(stat: Pnng_stat; s: Tnng_socket): Pnng_stat; cdecl; external NNG_LIB;

// nng_stat_find_dialer is used to find the stats for the given dialer.
function nng_stat_find_dialer(stat: Pnng_stat; d: Tnng_dialer): Pnng_stat; cdecl; external NNG_LIB;

// nng_stat_find_listener is used to find the stats for the given listener.
function nng_stat_find_listener(stat: Pnng_stat; l: Tnng_listener): Pnng_stat; cdecl; external NNG_LIB;

// nng_stat_unit provides information about the unit for the statistic,
// such as NNG_UNIT_BYTES or NNG_UNIT_BYTES.  If no specific unit is
// applicable, such as a relative priority, then NN_UNIT_NONE is returned.
function nng_stat_unit(stat: Pnng_stat): Integer; cdecl; external NNG_LIB;

// nng_stat_value returns returns the actual value of the statistic.
// Statistic values reflect their value at the time that the corresponding
// snapshot was updated, and are undefined until an update is performed.
function nng_stat_value(stat: Pnng_stat): UInt64; cdecl; external NNG_LIB;

// nng_stat_string returns the string associated with a string statistic,
// or NULL if the statistic is not part of the string.  The value returned
// is valid until the associated statistic is freed.
function nng_stat_string(stat: Pnng_stat): PAnsiChar; cdecl; external NNG_LIB;

// nng_stat_desc returns a human readable description of the statistic.
// This may be useful for display in diagnostic interfaces, etc.
function nng_stat_desc(stat: Pnng_stat): PAnsiChar; cdecl; external NNG_LIB;

// nng_stat_timestamp returns a timestamp (milliseconds) when the statistic
// was captured.  The base offset is the same as used by nng_clock().
// We don't use nng_time though, because that's in the supplemental header.
function nng_stat_timestamp(stat: Pnng_stat): UInt64; cdecl; external NNG_LIB;

// Device functionality.  This connects two sockets together in a device,
// which means that messages from one side are forwarded to the other.
function nng_device(s1: Tnng_socket; s2: Tnng_socket): Integer; cdecl; external NNG_LIB;

// Symbol name and visibility.  TBD.  The only symbols that really should
// be directly exported to runtimes IMO are the option symbols.  And frankly
// they have enough special logic around them that it might be best not to
// automate the promotion of them to other APIs.  This is an area open
// for discussion.

// Error codes.  These generally have different values from UNIX errnos,
// so take care about converting them.  The one exception is that 0 is
// unambiguously "success".
//
// NNG_SYSERR is a special code, which allows us to wrap errors from the
// underlying operating system.  We generally prefer to map errors to one
// of the above, but if we cannot, then we just encode an error this way.
// The bit is large enough to accommodate all known UNIX and Win32 error
// codes.  We try hard to match things semantically to one of our standard
// errors.  For example, a connection reset or aborted we treat as a
// closed connection, because that's basically what it means.  (The remote
// peer closed the connection.)  For certain kinds of resource exhaustion
// we treat it the same as memory.  But for files, etc. that's OS-specific,
// and we use the generic below.  Some of the above error codes we use
// internally, and the application should never see (e.g. NNG_EINTR).
//
// NNG_ETRANERR is like ESYSERR, but is used to wrap transport specific
// errors, from different transports.  It should only be used when none
// of the other options are available.

// URL support.  We frequently want to process a URL, and these methods
// give us a convenient way of doing so.

// nng_url_parse parses a URL string into a structured form.
// Note that the u_port member will be filled out with a numeric
// port if one isn't specified and a default port is appropriate for
// the scheme.  The URL structure is allocated, along with individual
// members.  It can be freed with nng_url_free.
function nng_url_parse(var result: Pnng_url; const url: PAnsiChar): Integer; cdecl; external NNG_LIB;

// nng_url_free frees a URL structure that was created by nng_url_parse().
procedure nng_url_free(url: Pnng_url); cdecl; external NNG_LIB;

// nng_url_clone clones a URL structure.
function nng_url_clone(var dstp: Pnng_url; const src: Pnng_url): Integer; cdecl; external NNG_LIB;

// nng_version returns the library version as a human readable string.
function nng_version: PAnsiChar; cdecl; external NNG_LIB;

// nng_stream operations permit direct access to low level streams,
// which can have a variety of uses.  Internally most of the transports
// are built on top of these.  Streams are created by other dialers or
// listeners.  The API for creating dialers and listeners varies.

procedure nng_stream_free(s: Pnng_stream); cdecl; external NNG_LIB;
procedure nng_stream_close(s: Pnng_stream); cdecl; external NNG_LIB;
procedure nng_stream_send(s: Pnng_stream; aio: Pnng_aio); cdecl; external NNG_LIB;
procedure nng_stream_recv(s: Pnng_stream; aio: Pnng_aio); cdecl; external NNG_LIB;
function nng_stream_get(s: Pnng_stream; const name: PAnsiChar; data: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_get_bool(s: Pnng_stream; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_stream_get_int(s: Pnng_stream; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_stream_get_ms(s: Pnng_stream; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_stream_get_size(s: Pnng_stream; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_get_uint64(s: Pnng_stream; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_stream_get_string(s: Pnng_stream; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_get_ptr(s: Pnng_stream; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_stream_get_addr(s: Pnng_stream; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;
function nng_stream_set(s: Pnng_stream; const name: PAnsiChar; const val: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_set_bool(s: Pnng_stream;const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_stream_set_int(s: Pnng_stream; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_stream_set_ms(s: Pnng_stream; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_stream_set_size(s: Pnng_stream; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_set_uint64(s: Pnng_stream; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_stream_set_string(s: Pnng_stream; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_set_ptr(s: Pnng_stream; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_stream_set_addr(s: Pnng_stream; const name: PAnsiChar; const val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

function nng_stream_dialer_alloc(var d: Pnng_stream_dialer; const url: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_alloc_url(var d: Pnng_stream_dialer; const url: Pnng_url): Integer; cdecl; external NNG_LIB;
procedure nng_stream_dialer_free(d: Pnng_stream_dialer); cdecl; external NNG_LIB;
procedure nng_stream_dialer_close(d: Pnng_stream_dialer); cdecl; external NNG_LIB;
procedure nng_stream_dialer_dial(d: Pnng_stream_dialer; aio: Pnng_aio); cdecl; external NNG_LIB;
function nng_stream_dialer_set(d: Pnng_stream_dialer; const name: PAnsiChar; const data: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get(d: Pnng_stream_dialer; const name: PAnsiChar; data: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_bool(d: Pnng_stream_dialer; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_int(d: Pnng_stream_dialer; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_ms(d: Pnng_stream_dialer; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_size(d: Pnng_stream_dialer; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_uint64(d: Pnng_stream_dialer; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_string(d: Pnng_stream_dialer; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_ptr(d: Pnng_stream_dialer; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_get_addr(d: Pnng_stream_dialer; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_bool(d: Pnng_stream_dialer; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_int(d: Pnng_stream_dialer; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_ms(d: Pnng_stream_dialer; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_size(d: Pnng_stream_dialer; const name: PAnsiChar; val: NativeUint): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_uint64(d: Pnng_stream_dialer; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_string(d: Pnng_stream_dialer; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_ptr(d: Pnng_stream_dialer; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_stream_dialer_set_addr(d: Pnng_stream_dialer; const name: PAnsiChar; const val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

function nng_stream_listener_alloc(var l: Pnng_stream_listener; const url: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_alloc_url(var l: Pnng_stream_listener; const url: Pnng_url): Integer; cdecl; external NNG_LIB;
procedure nng_stream_listener_free(l: Pnng_stream_listener); cdecl; external NNG_LIB;
procedure nng_stream_listener_close(l: Pnng_stream_listener); cdecl; external NNG_LIB;
function  nng_stream_listener_listen(l: Pnng_stream_listener): Integer; cdecl; external NNG_LIB;
procedure nng_stream_listener_accept(l: Pnng_stream_listener; aio: Pnng_aio); cdecl; external NNG_LIB;
function nng_stream_listener_set(l: Pnng_stream_listener; const name: PAnsiChar; const data: Pointer; sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get(l: Pnng_stream_listener; const name: PAnsiChar; data: Pointer; var sz: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_bool(l: Pnng_stream_listener; const name: PAnsiChar; var val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_int(l: Pnng_stream_listener; const name: PAnsiChar; var val: Integer): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_ms(l: Pnng_stream_listener; const name: PAnsiChar; var val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_size(l: Pnng_stream_listener; const name: PAnsiChar; var val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_uint64(l: Pnng_stream_listener; const name: PAnsiChar; var val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_string(l: Pnng_stream_listener; const name: PAnsiChar; var val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_ptr(l: Pnng_stream_listener; const name: PAnsiChar; var val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_get_addr(l: Pnng_stream_listener; const name: PAnsiChar; val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_bool(l: Pnng_stream_listener; const name: PAnsiChar; val: Boolean): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_int(l: Pnng_stream_listener; const name: PAnsiChar; val: Integer): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_ms(l: Pnng_stream_listener; const name: PAnsiChar; val: Tnng_duration): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_size(l: Pnng_stream_listener; const name: PAnsiChar; val: NativeUInt): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_uint64(l: Pnng_stream_listener; const name: PAnsiChar; val: UInt64): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_string(l: Pnng_stream_listener; const name: PAnsiChar; const val: PAnsiChar): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_ptr(l: Pnng_stream_listener; const name: PAnsiChar; val: Pointer): Integer; cdecl; external NNG_LIB;
function nng_stream_listener_set_addr(l: Pnng_stream_listener; const name: PAnsiChar; const val: Pnng_sockaddr): Integer; cdecl; external NNG_LIB;

implementation

end.
