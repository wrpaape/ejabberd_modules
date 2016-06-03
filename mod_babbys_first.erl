-module(mod_babbys_first).

-behaviour(gen_mod).

-include("ejabberd.hrl").
-include("logger.hrl").

-export([start/2,
         stop/1,
         mod_opt_type/1]).



start(_Host, _Opt) ->
  ?INFO_MSG("starting module 'mod_babbys_first'", []),
  ok.


stop(_Host) ->
  ?INFO_MSG("stopping module 'mod_babbys_first'", []),
  ok.


mod_opt_type(cache_life_time) -> fun (I) when is_integer(I), I > 0 -> I end;

mod_opt_type(cache_size)      -> fun (I) when is_integer(I), I > 0 -> I end;
mod_opt_type(db_type)         -> fun gen_mod:v_db/1;

mod_opt_type(default)         -> fun (always) -> always;
                                     (never)  -> never;
                                     (roster) -> roster
                                 end;

mod_opt_type(iqdisc)          -> fun gen_iq_handler:check_type/1;

mod_opt_type(store_body_only) -> fun (B) when is_boolean(B) -> B end;

mod_opt_type(_)               -> [cache_life_time,
                                  cache_size,
                                  db_type,
                                  default,
                                  iqdisc,
                                  store_body_only].
