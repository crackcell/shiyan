%%%-------------------------------------------------------------------
%%% @author crackcell <tanmenglong@gmail.com>
%%% @copyright (c) 2013, crackcell
%%% @doc
%%% file desc
%%% @end
%%% Created : Tue Oct  1 20:49:38 2013
%%%-------------------------------------------------------------------

-module(collector_acceptor).
-author('tanmenglong@gmail.com').
-behaviour(gen_server).

%% API
-export([start_link/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {socket}).

%%%===================================================================
%%% API
%%%===================================================================

start_link(Socket) ->
    gen_server:start_link(?MODULE, Socket, []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
init(Socket) ->
    % Seeding the process
    %<<A:32, B:32, C:32>> = crypto:rand_bytes(12),
    %random:seed({A, B, C}),
    gen_server:cast(self(), accept),
    {ok, #state{socket=Socket}}.

%% @private
%% Never used
handle_call(_Request, _From, State) ->
    {noreply, State}.

%% @private
handle_cast(accept, State=#state{socket=ListenSocket}) ->
    lager:info("a new worker started"),
    {ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
    collector_listener:start_child(), % A new acceptor is born
    send(AcceptSocket, "Hello world", []),
    %{noreply, State#state{socket=AcceptSocket}}.
    gen_tcp:close(AcceptSocket),
    {stop, normal, State}.

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

send(Socket, Str, Args) ->
    ok = gen_tcp:send(Socket, io_lib:format(Str++"~n", Args)),
    ok = inet:setopts(Socket, [{active, once}]),
    ok.

%%%===================================================================
%%% Unit tests
%%%===================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
