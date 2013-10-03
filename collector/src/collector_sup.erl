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
-export([start_link/0, start_child/0, start_children/1]).

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

start_child() ->
    supervisor:start_child(?MODULE, []).

start_children(N) when is_integer(N) ->
    [start_child() || _ <- lists:seq(1,N)].

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%% @private
init([]) ->
    %{ok, Port} = application:get_env(port),
    Port = 9001,
    %% Set the socket into {active_once} mode.
    %% See sockserv_serv comments for more details.
    {ok, ListenSocket} = gen_tcp:listen(Port, [{active,once}, {packet,line}]),
    spawn_link(fun start_init_children/0),
    {ok, {{simple_one_for_one, 60, 3600},
          [{ipshow_worker,
            {ipshow_worker, start_link, [ListenSocket]}, %Pass the socket!
            temporary, 1000, worker, [ipshow_worker]}
           ]}}.


%%%===================================================================
%%% Internal functions
%%%===================================================================

start_init_children() ->
    ipshow_sup:start_children(10).
