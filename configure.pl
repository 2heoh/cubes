#!/usr/bin/perl

use strict;
use Cwd;
use Data::Dumper;

my $current_dir = cwd;

print "working $current_dir...\n";
opendir(DIR, $current_dir);
my @files = grep /\.in$/, grep (!/^\./,readdir(DIR));
closedir DIR; 


foreach my $file (@files) {
    $file = "$current_dir/$file";
    $file =~ s/(.*)\.in$/$1/g; 
    print "processing: $file\n";
    my $content;
    open FILE, "$file.in";
    while(<FILE>) {
        $content .= $_;
    }
    close FILE;

    $content =~ s/\%rootpath\%/$current_dir/g;

    open OUT, ">$file";
    print OUT $content;
    close OUT;

}
