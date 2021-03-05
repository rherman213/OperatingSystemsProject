#!/usr/bin/perl
use Getopt::Std;


##############################################################################
#
# This program is used to test a malloclab submission for correctness and
# performance using mdriver.
#
##############################################################################

sub usage 
{
    printf STDERR "$_[0]\n";
    printf STDERR "Usage: $0 [-h] [-s SECONDS]\n";
    printf STDERR "Options:\n";
    printf STDERR "  -h              Print this message\n";
    printf STDERR "  -s SECONDS      Set driver timeout\n";
    die "\n" ;
}

# Generic setting
$| = 1;      # Autoflush output on every print statement

# Settings
# Driver timeout
$timeout = 1000;

getopts('hs:');

if ($opt_h) {
    usage($ARGV[0]);
}

if ($opt_s) {
    $timeout = $opt_s;
}

$callibration_flags = "";
$driver_flags = "";

# Run callibration program
$callibration_prog = "./callibrate.pl";

if (!-e $callibration_prog) {
    die "Cannot find callibration program $callibration_prog\n";
}

system("$callibration_prog $callibration_flags");

# Run macro checker
$macro_check = `./macro-check.pl -f mm.c`;

if ($macro_check ne "") {
    print $macro_check;
    print "FAILED macro check: You are not allowed to use macros for this assignment. Use static functions instead.\n";
    print "Score: Checkpoint 1: 0 / 50, Checkpoint 2: 0 / 100, Final: 0 / 100\n";
    exit;
}

$driver_prog = "./mdriver";

if (!-e $driver_prog) {
    die "Cannot find driver program '$driver_prog'\n";
}

print "Running $driver_prog -s $timeout $driver_flags\n";

system("$driver_prog -s $timeout $driver_flags 2>&1")
