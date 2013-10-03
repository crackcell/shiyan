#!/usr/bin/env bash
IPSHOW_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" IPSHOW_CONF="priv/conf/ipshow.conf" erl -pa ebin -pa deps/*/ebin
