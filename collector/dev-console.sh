#!/usr/bin/env bash
COLLECTOR_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" \
COLLECTOR_CONF="priv/conf/ipshow.conf" \
erl -name $USER@$(hostname) \
 -pa ebin -pa deps/*/ebin
