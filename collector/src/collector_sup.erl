%%%-------------------------------------------------------------------
%%% @author crackcell <tanmenglong@gmail.com>
%%% @copyright (c) 2013, crackcell
%%% @doc
%%% file desc
%%% @end
%%% Created : Tue Oct  1 20:42:17 2013
%%%-------------------------------------------------------------------

-module(collector_sup).
-author('tanmenglong@gmail.com').
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the supervisor
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%% @private
init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 60,
    MaxSecondsBetweenRestarts = 3600,
    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    Listener = {collector_listener,
                {collector_listener, start_link, []},
                permanent, 1000, supervisor, [collector_listener]},
    Infodb = {collector_infodb, {collector_infodb, start_link, []},
              permanent, 1000, worker, [collector_infodb]},
    Children = [Listener, Infodb],
    {ok, {SupFlags, Children}}.


%%%===================================================================
%%% Internal functions
%%%===================================================================
