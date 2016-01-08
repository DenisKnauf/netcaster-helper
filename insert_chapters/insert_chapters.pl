#!/usr/bin/perl
use strict;
use warnings;

my $i = -1;
my @args;

if (!$ARGV[0] or '-h' eq $ARGV[0]) {
	print STDERR <<EOF;
Usage: $0 -h | chapters-file [ogg-file]
EOF
}

open (my $f, '<', $ARGV[0])  or  die "Can't open file [$ARGV[0]]: $@";
while (<$f>) {
	chomp;
	my ($ts, $line) = split (/\s/, $_, 2);
	$ts = "0$ts"  if $ts =~ /^\d:/;
	$ts = "$ts.000"  if $ts =~ /:\d\d$/;
	$ts = "${ts}00"  if $ts =~ /:\d\d\.\d$/;
	$ts = "${ts}0"   if $ts =~ /:\d\d\.\d\d$/;
	my $fl = '- ';
	if ($ts =~ /^\d\d:\d\d:\d\d\.\d\d\d$/) {
		$i++;
		$fl = '';
		push @args, sprintf ("CHAPTER%03d=%s", $i, $ts);
	}
	push @args, sprintf ("CHAPTER%03dNAME=%s%s", $i, $fl, $line)  if '' eq $fl;
}
close ($f);

if ($ARGV[1]) {
	exec 'vorbiscomment', '-w', $ARGV[1], map {('-t', $_)} @args;
}
else {
	print "$_\n"  for @args;
}
