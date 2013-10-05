%%%-*- encoding: utf-8; indent-tabs-mode: nil -*-
%%%-------------------------------------------------------------------
%%% @author crackcell <tanmenglong@gmail.com>
%%% @copyright (c) 2013, crackcell
%%% @doc
%%% file desc
%%% @end
%%% Created : Sat Oct  5 13:19:40 2013
%%%-------------------------------------------------------------------

-module(collector_utils).
-author('tanmenglong@gmail.com').
-export([trim/1, trim_last/1, get_app_env/1]).

%%%===================================================================
%%% API
%%%===================================================================

trim(Str) ->
    binary_to_list(lists:nth(1, lists:flatten(re:replace(Str, "[\r\n]", "", [global])))).

trim_last(Str) ->
    hd(string:tokens(Str, "\r\n")).

get_app_env(Key) ->
    case application:get_env(collector, Key) of
        {ok, Value} -> Value;
        _ -> error(invalid_conf)
    end.

%%%===================================================================
%%% Internal functions
%%%===================================================================


%%%===================================================================
%%% Unit tests
%%%===================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
