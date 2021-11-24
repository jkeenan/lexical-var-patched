use warnings;
use strict;

use Test::More tests => 18;

BEGIN { $^H |= 0x20000 if "$]" < 5.008; }

$SIG{__WARN__} = sub { die "WARNING: $_[0]" };

eval q{use Lexical::Var::Patched '&foo' => \undef;};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => \1;};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => \1.5;};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => \[];};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => \"abc";};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => bless(\(my$x="abc"));};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => \*main::wibble;};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => bless(\*main::wibble);};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => qr/xyz/;};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => bless(qr/xyz/);};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => [];};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => bless([]);};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => {};};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => bless({});};
isnt $@, "";
eval q{use Lexical::Var::Patched '&foo' => sub{};};
is $@, "";
eval q{use Lexical::Var::Patched '&foo' => bless(sub{});};
is $@, "";

eval q{use Lexical::Var::Patched '&foo' => sub{}; &foo if 0;};
is $@, "";
eval q{use Lexical::Var::Patched '&foo' => bless(sub{}); &foo if 0;};
is $@, "";

1;
