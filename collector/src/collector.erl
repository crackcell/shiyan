%%%-*- encoding: utf-8; indent-tabs-mode: nil -*-
%%%-------------------------------------------------------------------
%%% @author crackcell <tanmenglong@gmail.com>
%%% @copyright (c) 2013, crackcell
%%% @doc
%%% file desc
%%% @end
%%% Created : Fri Oct  4 15:56:37 2013
%%%-------------------------------------------------------------------

-module(collector).
-author('tanmenglong@gmail.com').
-export([start/0, stop/0, install_database/2]).

-include("schema.hrl").

%%%===================================================================
%%% API
%%%===================================================================

start() ->
    setenv(),
    application:start(lager),
    application:start(mnesia),
    mnesia:wait_for_tables([shiyan_nodeinfo], 5000),
    application:start(collector).

stop() ->
    application:stop(collector).

install_database(Nodes, Path) ->
    application:set_env(mnesia, dir, Path),
    mnesia:create_schema([node()]),
    rpc:multicall(Nodes, application, start, [mnesia]),
    mnesia:create_table(shiyan_nodeinfo,
                        [{attributes, record_info(fields, shiyan_nodeinfo)},
                        {disc_copies, Nodes}]),
    rpc:multicall(Nodes, application, stop, [mnesia]).

%%%===================================================================
%%% Internal functions
%%%===================================================================

setenv() ->
    application:set_env(mnesia, dir, "/home/crackcell/usr/lib/shiyan/data").

%%%===================================================================
%%% Unit tests
%%%===================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
