-module(mod_babbys_first).

-behaviour(gen_mod).

-include("ejabberd.hrl").
-include("logger.hrl").

-export([start/2,
         stop/1]).



start(_Host, _Opt) ->
  ?INFO_MSG("starting module 'mod_babbys_first'", []),
  ok.


stop(_Host) ->
  ?INFO_MSG("stopping module 'mod_babbys_first'", []),
  ok.
