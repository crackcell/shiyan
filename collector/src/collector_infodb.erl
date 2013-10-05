%%%-------------------------------------------------------------------
%%% @author crackcell <tanmenglong@gmail.com>
%%% @copyright (c) 2013, crackcell
%%% @doc
%%% file desc
%%% @end
%%% Created : Fri Oct  4 14:08:36 2013
%%%-------------------------------------------------------------------

-module(collector_infodb).
-author('tanmenglong@gmail.com').
-behaviour(gen_server).

-include("schema.hrl").

%% API
-export([start_link/0, add_nodeinfo/2, get_nodeinfo/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

add_nodeinfo(NodeName, NetInfo) ->
    gen_server:call(?SERVER, {add_nodeinfo, NodeName, NetInfo}).

get_nodeinfo(NodeName) ->
    gen_server:call(?SERVER, {get_nodeinfo, NodeName}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
init([]) ->
    lager:info("infodb started"),
    {ok, #state{}}.

%% @private
handle_call({add_nodeinfo, NodeName, NetInfo}, _From, State) ->
    F = fun() -> mnesia:write(#shiyan_nodeinfo{node_name=NodeName,
                                               net_info=NetInfo})
        end,
    Reply = mnesia:activity(transaction, F),
    {reply, Reply, State};
handle_call({get_nodeinfo, NodeName}, _From, State) ->
    F = fun() -> case mnesia:read(shiyan_nodeinfo, NodeName) of
                     [] -> undefined;
                     Other -> Other
                 end
        end,
    Reply = lists:nth(1, mnesia:activity(transaction, F)),
    {reply, Reply, State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

%% @private
handle_cast(_Msg, State) ->
    {noreply, State}.

%% @private
handle_info(_Info, State) ->
    {noreply, State}.

%% @private
terminate(_Reason, _State) ->
    ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================


%%%===================================================================
%%% Unit tests
%%%===================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
