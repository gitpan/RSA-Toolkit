package RSA::Toolkit;

use 5.008008;
use strict;
use warnings;
use DynaLoader;

our $VERSION = '0.02';
our @ISA = qw(DynaLoader);

bootstrap RSA::Toolkit;


sub new{
	my $class = shift;
	my $type = ref($class) || $class;
	my $self = bless {}, $type;

	$self->connect;
	$self;
}

sub fetch_users {
	my $self = shift;
	my $arg_ref = { @_ };

	my $field = $arg_ref->{'field'} || 0;
	my $type = $arg_ref->{'type'} || 0;
	my $value = $arg_ref->{'value'} || '';
	
	use RSA::Toolkit::User;
	my $user = $self->_fetch_users($field, $type, $value);
	$user->_reformat;
}

1;

