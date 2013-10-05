%%%-------------------------------------------------------------------
%%% @author crackcell <tanmenglong@gmail.com>
%%% @copyright (c) 2013, crackcell
%%% @doc
%%% file desc
%%% @end
%%% Created : Tue Oct  1 20:42:17 2013
%%%-------------------------------------------------------------------

-module(collector_listener).
-author('tanmenglong@gmail.com').
-behaviour(supervisor).

%% API
-export([start_link/1, start_child/0, start_children/1]).

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
start_link(Properties) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, Properties).

start_child() ->
    supervisor:start_child(?MODULE, []).

start_children(N) when is_integer(N) ->
    [start_child() || _ <- lists:seq(1,N)].

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%% @private
init(Properties) ->
    io:format("prop: ~p~n", [Properties]),
    Port = hd(orddict:fetch(port, Properties)),
    WorkerNumber = hd(orddict:fetch(worker_num, Properties)),
    io:format("prop: ~p, ~p~n", [Port, WorkerNumber]),
    {ok, ListenSocket} = gen_tcp:listen(Port, [{active,once}, {reuseaddr, true}]),
    lager:info("started listening on port ~B", [Port]),
    %spawn_link(fun start_init_children/0),
    spawn_link(
      fun() ->
              collector_listener:start_children(WorkerNumber),
              lager:info("started ~B workers", [WorkerNumber])
      end),

    RestartStrategy = simple_one_for_one,
    MaxRestarts = 60,
    MaxSecondsBetweenRestarts = 3600,
    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    Acceptor = {collector_acceptor,
                {collector_acceptor, start_link, [ListenSocket]},
                transient, 1000, worker, [collector_acceptor]},
    Children = [Acceptor],
    {ok, {SupFlags, Children}}.


%%%===================================================================
%%% Internal functions
%%%===================================================================
