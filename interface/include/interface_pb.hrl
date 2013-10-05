-ifndef(NETINTERFACEINFO_PB_H).
-define(NETINTERFACEINFO_PB_H, true).
-record(netinterfaceinfo, {
    device,
    inet,
    inet6,
    netmask,
    netmask6
}).
-endif.

-ifndef(NETINFO_PB_H).
-define(NETINFO_PB_H, true).
-record(netinfo, {
    addresses = []
}).
-endif.

-ifndef(INFO_PB_H).
-define(INFO_PB_H, true).
-record(info, {
    net_info
}).
-endif.

-ifndef(REQUEST_PB_H).
-define(REQUEST_PB_H, true).
-record(request, {
    processor = erlang:error({required, processor}),
    command = erlang:error({required, command}),
    info
}).
-endif.

