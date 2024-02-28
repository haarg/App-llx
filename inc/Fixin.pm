package Fixin;
use strict;
use warnings;
use ExtUtils::MY;
our @ISA = qw(MY);

sub fixin {
  my ($self, @files) = @_;

  for my $file (@files) {
    open my $fh, '<:raw', $file
      or die "can't read $file: $!";
    open my $new_fh, '>:raw', "$file.new"
      or die "can't write $file.new: $!";

    my $line = <$fh>;
    $line =~ s{\A#!/usr/bin/env perl\b}{#!/usr/bin/perl};
    print $new_fh $line;
    while (my $line = <$fh>) {
      print $new_fh $line;
    }
    close $new_fh;
    close $fh;

    rename "$file.new", "$file";
  }

  $self->SUPER::fixin(@files);
}

1;
