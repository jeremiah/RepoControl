#!/usr/bin/perl

=head1 NAME

RepoControl.pm

=head1 PURPOSE

A library for moving debian packages
around a file system and repository

=cut

package RepoControl;
use Moose;

has 'debname' => (isa => 'Str', is => 'rw');
has 'destination' => (isa => 'Str', is => 'rw', required => 1, default => "/tmp/");

sub copy_file {
  use File::Copy qw/cp/;
  my ($self, $to_dir, $deb) = @_;
  # Do some file checking
  if (-e $deb) {
    $self->debname($deb);
  }
  else {
    die "$deb does not exist.\n";
  }

  # If to directory is not defined, switch to default
  if ($to_dir) {
    $self->destination($to_dir);
  }
  cp ($self->debname, $self->destination)
    or warn "Cannot move file " . $self->debname . " to " . $self->destination .": $!\n";
  return $self->destination;
}

no Moose;

__PACKAGE__->meta->make_immutable;

1;
