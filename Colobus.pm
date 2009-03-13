package Colobus;
use strict;
use vars qw(@EXPORT_OK @ISA %config %groups %feeds);
use Exporter;
@EXPORT_OK = qw(%config %groups %feeds get_group_max open_article);
@ISA = qw(Exporter);

%config = (
  timeout    => 300,
  servername => 'news',
);

sub read_config {
  my $file = shift || "config";
  my $fh;
  open $fh, "<$file"
    or die "unable to open file '$file': $!";

  my ($group, $feed);

  while (<$fh>) {
    chomp;
    next if m/^\s*#/;
    next unless /\S/;

    $group = $feed = undef, next if m/}/;

    my ($k,$v) = map { s/^\s*(.+?)\s*$/$1/; $_; } split /=>/;
    if ($k) {
      read_config($v), next if lc $k eq "include";
      $feeds{$feed}{$k} = $v, next
	if $feed;
      $groups{$group}{$k} = $v, next
	if $group;
      $config{$k} = $v;
    }

    unless ($group or $feed) {
      if (my ($k) = $_ =~ m/\s*(.*?)\s*{/) {
	($k =~ s/^(feed|group)\s+// and defined $1 and $1 eq "feed") 
	  ? $feed = $k
	    : $group = $k;
      }
    }

  }
  close $fh;
}

sub get_group_max {
  my ($group) = lc shift
    or return;
  return unless exists $groups{$group};
  my $num_file = $groups{$group}->{path}."/num";
  if (open FILE, "<$num_file") {
    my ($max) = (<FILE> =~ m/^(\d+)/);
    close FILE;
    return $max;
  }
  else {
    warn "Could not open $num_file: $!\n";
  }
}

sub open_article {
  my ($group,$artno) = @_;
  return unless exists $groups{$group};
  my $fh = Symbol::gensym();
  my $file = sprintf("%s/archive/%d/%02d", $groups{$group}->{path},
                     int $artno / 100, $artno % 100);
  open $fh, "<$file"
    or return;
  return $fh;
}


1;
