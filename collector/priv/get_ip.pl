#!/usr/bin/perl
##! @description: usage
##! @version: 1
##! @author: crackcell <tanmenglong@gmail.com>
##! @date:   Sat Oct  5 21:54:18 2013

use strict;

#--------------- global variable --------------


#------------------ function ------------------


#------------------- main -------------------

my $info = "";

my $cmd = `ifconfig | grep \"inet addr\"`;
my @lines = split(/\n/, $cmd);
foreach my $line (@lines) {
    $line =~ s/^\s+//;
    $line =~ s/\s+$//;
    if ($line =~ /addr:(.*?) /) {
        $info = $info . $1 . " ";
    }
}
print $info, "\n";
