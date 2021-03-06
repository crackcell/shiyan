#!/usr/bin/perl
##! @description: usage
##! @version: 1
##! @author: crackcell <tanmenglong@gmail.com>
##! @date:   Sat Oct  5 21:54:18 2013

use strict;

#--------------- global variable --------------

my $host = "vps0.crackcell.com";
my $port = 9601;

#------------------ function ------------------

sub usage {
    print("Usage: collector_client.pl COMMAND\n");
    print(" Commands:\n");
    print("  add_nodeinfo\n");
    print("  get_nodeinfo\n");
}

#------------------- main -------------------

sub get_ip {
    my $info = "";

    my $cmd = `ifconfig | grep \"inet addr\"`;
    my @lines = split(/\n/, $cmd);
    foreach my $line (@lines) {
        $line =~ s/^\s+//;
        $line =~ s/\s+$//;
        if ($line =~ /addr:(.*?) /) {
            $info = $info . $1 . ";";
        }
    }
    return $info;
}

sub add_nodeinfo {
    my $hostname = `hostname`;
    chomp($hostname);
    my $cmd = "(echo \"add_nodeinfo\\t$hostname\\t" . get_ip() . "\"; sleep 5) | nc $host $port";
    print $cmd, "\n";
    print `$cmd`;
}

sub get_nodeinfo {
    my $hostname = `hostname`;
    chomp($hostname);
    my $cmd = "(echo \"get_nodeinfo\\t$hostname\"; sleep 5) | nc $host $port";
    print $cmd, "\n";
    print `$cmd`;
}

if (scalar @ARGV < 1) {
    usage();
    exit 0;
}

if ($ARGV[0] eq "add_nodeinfo") {
    add_nodeinfo();
} else {
    get_nodeinfo();
}
