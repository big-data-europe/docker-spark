#!/usr/bin/env perl

use strict;
use warnings;
use IO::Select;

pipe(CHILD_STDOUT_R, CHILD_STDOUT_W);
pipe(CHILD_STDERR_R, CHILD_STDERR_W);

system("/wait-for-step.sh") == 0 or die "invalid exit status: $?";
system("/execute-step.sh") == 0 or die "invalid exit status: $?";

if( my $child = fork )
{

  $SIG{HUP} = sub {
    warn "What's HUP doc?\n";
    kill 'HUP', $child;
  };
  $SIG{INT} = sub {
    warn "How DARE you interrupt me!\n";
    kill 'INT', $child;
  };
  $SIG{TERM} = sub {
    warn "MUST TERMINATE ALL HUMANS\n";
    kill 'TERM', $child;
  };

  $SIG{CHLD} = sub {
    my $pid = wait;
    if( $pid == $child ) {
      close(CHILD_STDOUT_W);
      close(CHILD_STDERR_W);
    }
  };

  my $s = IO::Select->new(\*CHILD_STDOUT_R, \*CHILD_STDERR_R);
  PIPES: while( my @ready = $s->can_read )
  {
    for my $fh (@ready)
    {
      last PIPES if eof($fh);
      $_ = <$fh>;
      print STDOUT if fileno($fh) == fileno(CHILD_STDOUT_R);
      print STDERR if fileno($fh) == fileno(CHILD_STDERR_R);

      if( m/Worker: Successfully registered with master/ )
      {
        system("/finish-step.sh") == 0 or warn "invalid exit status: $?";
      }
    }
  }

}
else
{

  STDOUT->fdopen(\*CHILD_STDOUT_W, 'w') or die $!;
  STDERR->fdopen(\*CHILD_STDERR_W, 'w') or die $!;
  exec("/bin/bash", "/worker.sh");

}
