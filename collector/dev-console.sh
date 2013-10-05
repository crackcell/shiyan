#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/priv/collector.conf

port=$port worker_num=$worker_num data_dir=$data_dir \
erl -name $USER@$(hostname) \
 -pa ebin -pa $DIR/../deps/*/ebin \
 -pa $DIR/ebin
