-module(collector_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, Properties} = get_env_conf(),
    collector_sup:start_link(Properties).

stop(_State) ->
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================

get_env_conf() ->
    Prop0 = orddict:new(),
    {Port, _} = string:to_integer(os:getenv("port")),
    Prop1 = orddict:append(port, Port, Prop0),
    {WorkerNumber, _} = string:to_integer(os:getenv("worker_num")),
    Prop2 = orddict:append(worker_num, WorkerNumber, Prop1),
    Prop3 = orddict:append(data_dir,
                           os:getenv("data_dir"),
                           Prop2),
    {ok, Prop3}.
