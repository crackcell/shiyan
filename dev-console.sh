#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

erl -name $USER@$(hostname) \
 -pa ebin -pa $DIR/deps/*/ebin \
 -pa $DIR/collector/ebin
