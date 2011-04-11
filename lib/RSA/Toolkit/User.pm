package RSA::Toolkit::User;

use 5.008008;
use strict;
use warnings;

our $VERSION = '0.02';


sub get_inf {
	my $self = shift;
	my $key = shift;

	if ($self->{$key}) {
		return $self->{$key};
	}else{
		return $self->{'inf'}{$key} if $self->{'inf'}{$key};
		return $self->{'inf_ext'}{$key} if $self->{'inf_ext'}{$key};
	}
	return '';
}

sub get_inf_fields {
	my $self = shift;

	my @fields;
	push (@fields, keys %{$self->{'inf'}}) if $self->{'inf'};
	push (@fields, keys %{$self->{'inf_ext'}}) if $self->{'inf_ext'};
	push (@fields, grep {!/inf|inf_ext/} keys %{$self->dump});
	@fields;
}

sub dump {
	my $self = shift;
	my %hash = %$self;
	\%hash;
}

sub _reformat {
	my $self = shift;
	
	my $inf_ext = $self->{'inf_ext'};
	my $inf = $self->{'inf'};
	my $group = $self->{'group'};
	
	# Formating the extension information
	my %hash_inf_ext;
	foreach my $entry (@$inf_ext) {
		my ($key, $val) = split(/ , /, $entry, 2);
		next if $key =~ /\n/;
		$hash_inf_ext{$key} = $val;
	}
	$self->{'inf_ext'} = \%hash_inf_ext;

	# Formating user's name
	my %hash_inf;
	my ($a, $b, $c) = split(/\s\|\s/, $inf, 4);
	$hash_inf{'gn'} = $b;
	$hash_inf{'sn'} = $c;
	$self->{'inf'} = \%hash_inf;

	# Formating user's groups
	my @array_group;
	foreach my $entry (@$group) {
		my ($a, $b, $c) = split(/,/, $entry, 4);
		$c =~ s/(^\s+)|(\s+$)//g;
		push(@array_group, $c);
	}
	$self->{'group'} = \@array_group;

	$self;
}


1;

__END__

=head1 NAME

RSA::Toolkit::User - Perl extension for RSA Administration Toolkit

=head1 DESCRIPTION

This module is not for directly using. For more information, please refer to L<RSA::Toolkit>.

=head1 AUTHOR

Pan Yu, E<lt>xiaocong[AT]vip.163.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Pan Yu

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
