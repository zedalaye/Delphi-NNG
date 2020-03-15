unit nng.api.utils;

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
  nng.api;

// This is a relatively simple "options parsing" library, used to
// parse command line options.  We would use getopt(3), but there are
// two problems with getopt(3).  First, it isn't available on all
// platforms (especially Win32), and second, it doesn't support long
// options.  We *exclusively* support long options.  POSIX style
// short option clustering is *NOT* supported.

type
  Pnng_optspec = ^Tnng_optspec;
  Tnng_optspec = record
    o_name: PAnsiChar;  // Long style name (may be NULL for short only)
    o_short: Integer;   // Short option (no clustering!)
    o_val: Integer;     // Value stored on a good parse (>0)
    o_arg: Boolean;     // Option takes an argument if true
  end;

// Call with *optidx set to 1 to start parsing for a standard program.
// The val will store the value of the matched "o_val", optarg will be
// set to match the option string, and optidx will be increment appropriately.
// Returns -1 when the end of options is reached, 0 on success, or
// NNG_EINVAL if the option parse is invalid for any reason.
function nng_opts_parse(argc: Integer; argv: PPAnsiChar; const opts: Pnng_optspec;
  var val: Integer; var optarg: PAnsiChar; var optidx: Integer): Integer; cdecl; external NNG_LIB;


// The declarations in this file are provided to assist with application
// portability.  Conceptually these APIs are based on work we have already
// done for NNG internals, and we find that they are useful in building
// portable applications.

// If it is more natural to use native system APIs like pthreads or C11
// APIs or Windows APIs, then by all means please feel free to simply
// ignore this.

// nng_time represents an absolute time since some arbitrary point in the
// past, measured in milliseconds.  The values are always positive.
type
  Tnng_time = UInt64;

// Return an absolute time from some arbitrary point.  The value is
// provided in milliseconds, and is of limited resolution based on the
// system clock.  (Do not use it for fine grained performance measurements.)
function nng_clock: Tnng_time; cdecl; external NNG_LIB;

// Sleep for specified msecs.
procedure nng_msleep(ms: Tnng_duration); cdecl; external NNG_LIB;

// nng_thread is a handle to a "thread", which may be a real system
// thread, or a coroutine on some platforms.
type
  Pnng_thread = ^Tnng_thread;
  Tnng_thread = record
  end;

// Create and start a thread.  Note that on some platforms, this might
// actually be a coroutine, with limitations about what system APIs
// you can call.  Therefore, these threads should only be used with the
// I/O APIs provided by nng.  The thread runs until completion.
type
  Tnng_thread_fn = procedure(arg: Pointer); cdecl;

function nng_thread_create(var thread: Pnng_thread; fn: Tnng_thread_fn; arg: Pointer): Integer; cdecl; external NNG_LIB;

// Destroy a thread (waiting for it to complete.)  When this function
// returns all resources for the thread are cleaned up.
procedure nng_thread_destroy(thread: Pnng_thread); cdecl; external NNG_LIB;

// nng_mtx represents a mutex, which is a simple, non-reentrant, boolean lock.
type
  Pnng_mtx = ^Tnng_mtx;
  Tnng_mtx = record
  end;

// nng_mtx_alloc allocates a mutex structure.
function nng_mtx_alloc(var mtx: Pnng_mtx): Integer; cdecl; external NNG_LIB;

// nng_mtx_free frees the mutex.  It must not be locked.
procedure nng_mtx_free(mtx: Pnng_mtx); cdecl; external NNG_LIB;

// nng_mtx_lock locks the mutex; if it is already locked it will block
// until it can be locked.  If the caller already holds the lock, the
// results are undefined (a panic may occur).
procedure nng_mtx_lock(mtx: Pnng_mtx); cdecl; external NNG_LIB;

// nng_mtx_unlock unlocks a previously locked mutex.  It is an error to
// call this on a mutex which is not owned by caller.
procedure nng_mtx_unlock(mtx: Pnng_mtx); cdecl; external NNG_LIB;

// nng_cv is a condition variable.  It is always allocated with an
// associated mutex, which must be held when waiting for it, or
// when signaling it.
type
  Pnng_cv = ^Tnng_cv;
  Tnng_cv = record
  end;

function nng_cv_alloc(var cv: Pnng_cv; mtx: Pnng_mtx): Integer; cdecl; external NNG_LIB;

// nng_cv_free frees the condition variable.
procedure nng_cv_free(cv: Pnng_cv); cdecl; external NNG_LIB;

// nng_cv_wait waits until the condition variable is "signaled".
procedure nng_cv_wait(cv: Pnng_cv); cdecl; external NNG_LIB;

// nng_cv_until waits until either the condition is signaled, or
// the timeout expires.  It returns NNG_ETIMEDOUT in that case.
function nng_cv_until(cv: Pnng_cv; when: Tnng_time): Integer; cdecl; external NNG_LIB;

// nng_cv_wake wakes all threads waiting on the condition.
procedure nng_cv_wake(cv: Pnng_cv); cdecl; external NNG_LIB;

// nng_cv_wake1 wakes only one thread waiting on the condition.  This may
// reduce the thundering herd problem, but care must be taken to ensure
// that no waiter starves forever.
procedure nng_cv_wake1(cv: Pnng_cv); cdecl; external NNG_LIB;

// nng_random returns a "strong" (cryptographic sense) random number.
function nng_random: Cardinal; cdecl; external NNG_LIB;


implementation

end.
