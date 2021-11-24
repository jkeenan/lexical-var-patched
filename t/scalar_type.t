use warnings;
use strict;

use Test::More tests => 26;

BEGIN { $^H |= 0x20000 if "$]" < 5.008; }

$SIG{__WARN__} = sub { die "WARNING: $_[0]" };

eval q{use Lexical::Var::Patched '$foo' => \undef;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \1;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \1.5;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \[];};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \"abc";};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless(\(my$x="abc"));};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \*main::wibble;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless(\*main::wibble);};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => qr/xyz/;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless(qr/xyz/);};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => [];};
isnt $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless([]);};
isnt $@, "";
eval q{use Lexical::Var::Patched '$foo' => {};};
isnt $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless({});};
isnt $@, "";
eval q{use Lexical::Var::Patched '$foo' => sub{};};
isnt $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless(sub{});};
isnt $@, "";

eval q{use Lexical::Var::Patched '$foo' => \undef; $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \1; $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \1.5; $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \[]; $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \"abc"; $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless(\(my$x="abc")); $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => \*main::wibble; $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless(\*main::wibble); $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => qr/xyz/; $foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '$foo' => bless(qr/xyz/); $foo if 0;};
is $@, "";

1;
