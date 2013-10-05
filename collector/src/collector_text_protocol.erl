%%%-*- encoding: utf-8; indent-tabs-mode: nil -*-
%%%-------------------------------------------------------------------
%%% @author crackcell <tanmenglong@gmail.com>
%%% @copyright (c) 2013, crackcell
%%% @doc
%%% file desc
%%% @end
%%% Created : Sat Oct  5 13:17:17 2013
%%%-------------------------------------------------------------------

-module(collector_text_protocol).
-author('tanmenglong@gmail.com').
-export([parse_cmd_type/1, parse_add_nodeinfo/1, parse_get_nodeinfo/1]).

%%%===================================================================
%%% API
%%%===================================================================

parse_cmd_type(RawStr) ->
    Tokens = string:tokens(collector_utils:trim(RawStr), "\t"),
    case lists:nth(1, Tokens) of
        "add_nodeinfo" -> add_nodeinfo;
        "get_nodeinfo" -> get_nodeinfo;
        _ -> unknown
    end.

parse_add_nodeinfo(RawStr) ->
    Tokens = string:tokens(collector_utils:trim(RawStr), "\t"),
    NodeName = lists:nth(2, Tokens),
    Ip = lists:nth(3, Tokens),
    {ok, {NodeName, Ip}}.

parse_get_nodeinfo(RawStr) ->
    Tokens = string:tokens(collector_utils:trim(RawStr), "\t"),
    io:format("tokens: ~p~n", [Tokens]),
    NodeName = lists:nth(2, Tokens),
    {ok, NodeName}.

%%%===================================================================
%%% Internal functions
%%%===================================================================


%%%===================================================================
%%% Unit tests
%%%===================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
