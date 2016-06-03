-module(mod_babbys_first).

-behaviour(gen_mod).

-include("ejabberd.hrl").
-include("logger.hrl").
-include("ejabberd_http.hrl").

-export([start/2,
         stop/1,
         process/2,
         mod_opt_type/1]).



start(_Host, _Opt) ->
  ?INFO_MSG("starting module 'mod_babbys_first'", []),
  ok.


stop(_Host) ->
  ?INFO_MSG("stopping module 'mod_babbys_first'", []),
  ok.


process(Path, _Request) ->
  {xmlelement,
   "html",
   [{"xmlns",
     "http://www.w3.org/1999/xhtml"}],
   [{xmlelement,
     "head",
     [],
     [{xmlelement,
       "title",
       [],
       []}]},
    {xmlelement,
     "body",
     [],
     [{xmlelement,
       "p",
       [],
       [{xmlcdata,
         is_user_exists(Path)}]}]}]}.


is_user_exists(User) ->
  Result = ejabberd_auth:is_user_exists(User, "localhost"),
  case Result of
    true  -> "The username " ++ User ++ " is already taken.";
    false -> "The username " ++ User ++ " is available."
  end.


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
