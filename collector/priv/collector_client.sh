#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$3" in
    add_nodeinfo)
        echo -e "add_nodeinfo\t$4\t$( $DIR/get_ip.pl )" | nc $1 $2
        ;;
    get_nodeinfo)
        echo -e "get_nodeinfo\t$4" | nc $1 $2
        ;;
    *)
        echo "usage: $0 Hostname Port Command NodeName"
        echo "  Commands:"
        echo "    add_nodeinfo"
        echo "    get_nodeinfo"
        ;;
esac
