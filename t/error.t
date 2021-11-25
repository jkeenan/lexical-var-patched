use warnings;
use strict;

use Test::More tests => 53;

BEGIN { $SIG{__WARN__} = sub { die "WARNING: $_[0]" }; }

require_ok "Lexical::Var::Patched";

eval q{ Lexical::Var::Patched->import(); };
like $@, qr/\ALexical::Var::Patched does no default importation/;
eval q{ Lexical::Var::Patched->unimport(); };
like $@, qr/\ALexical::Var::Patched does no default unimportation/;
eval q{ Lexical::Var::Patched->import('foo'); };
like $@, qr/\Aimport list for Lexical::Var::Patched must alternate /;
eval q{ Lexical::Var::Patched->import('$foo', \1); };
like $@, qr/\Acan't set up lexical variable outside compilation/;
eval q{ Lexical::Var::Patched->unimport('$foo'); };
like $@, qr/\Acan't set up lexical variable outside compilation/;

eval q{ use Lexical::Var::Patched; };
like $@, qr/\ALexical::Var::Patched does no default importation/;
eval q{ no Lexical::Var::Patched; };
like $@, qr/\ALexical::Var::Patched does no default unimportation/;

eval q{ use Lexical::Var::Patched 'foo'; };
like $@, qr/\Aimport list for Lexical::Var::Patched must alternate /;

eval q{ use Lexical::Var::Patched undef, \1; };
like $@, qr/\Avariable name is not a string/;
eval q{ use Lexical::Var::Patched \1, sub{}; };
like $@, qr/\Avariable name is not a string/;
eval q{ use Lexical::Var::Patched undef, "wibble"; };
like $@, qr/\Avariable name is not a string/;

eval q{ use Lexical::Var::Patched 'foo', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ use Lexical::Var::Patched '$', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ use Lexical::Var::Patched '$foo(bar', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ use Lexical::Var::Patched '$1foo', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ use Lexical::Var::Patched '$foo\x{e9}bar', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ use Lexical::Var::Patched '$foo::bar', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ use Lexical::Var::Patched '!foo', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ use Lexical::Var::Patched 'foo', "wibble"; };
like $@, qr/\Amalformed variable name/;

eval q{ use Lexical::Var::Patched '$foo', "wibble"; };
like $@, qr/\Avariable is not scalar reference/;

eval q{ no Lexical::Var::Patched undef, \1; };
like $@, qr/\Avariable name is not a string/;
eval q{ no Lexical::Var::Patched \1, sub{}; };
like $@, qr/\Avariable name is not a string/;
eval q{ no Lexical::Var::Patched undef, "wibble"; };
like $@, qr/\Avariable name is not a string/;

eval q{ no Lexical::Var::Patched 'foo', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ no Lexical::Var::Patched '$', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ no Lexical::Var::Patched '$foo(bar', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ no Lexical::Var::Patched '$foo::bar', \1; };
like $@, qr/\Amalformed variable name/;
eval q{ no Lexical::Var::Patched '!foo', \1; };
like $@, qr/\Amalformed variable name/;

require_ok "Lexical::Sub::Patched";

eval q{ Lexical::Sub::Patched->import(); };
like $@, qr/\ALexical::Sub::Patched does no default importation/;
eval q{ Lexical::Sub::Patched->unimport(); };
like $@, qr/\ALexical::Sub::Patched does no default unimportation/;
eval q{ Lexical::Sub::Patched->import('foo'); };
like $@, qr/\Aimport list for Lexical::Sub::Patched must alternate /;

eval q{ use Lexical::Sub::Patched; };
like $@, qr/\ALexical::Sub::Patched does no default importation/;
eval q{ no Lexical::Sub::Patched; };
like $@, qr/\ALexical::Sub::Patched does no default unimportation/;

eval q{ use Lexical::Sub::Patched 'foo'; };
like $@, qr/\Aimport list for Lexical::Sub::Patched must alternate /;

eval q{ use Lexical::Sub::Patched undef, sub{}; };
like $@, qr/\Asubroutine name is not a string/;
eval q{ use Lexical::Sub::Patched sub{}, \1; };
like $@, qr/\Asubroutine name is not a string/;
eval q{ use Lexical::Sub::Patched undef, "wibble"; };
like $@, qr/\Asubroutine name is not a string/;

eval q{ use Lexical::Sub::Patched '$', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ use Lexical::Sub::Patched 'foo(bar', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ use Lexical::Sub::Patched '1foo', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ use Lexical::Sub::Patched 'foo\x{e9}bar', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ use Lexical::Sub::Patched 'foo::bar', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ use Lexical::Sub::Patched '!foo', sub{}; };
like $@, qr/\Amalformed subroutine name/;

eval q{ use Lexical::Sub::Patched 'foo', "wibble"; };
like $@, qr/\Asubroutine is not code reference/;

eval q{ no Lexical::Sub::Patched undef, sub{}; };
like $@, qr/\Asubroutine name is not a string/;
eval q{ no Lexical::Sub::Patched sub{}, \1; };
like $@, qr/\Asubroutine name is not a string/;
eval q{ no Lexical::Sub::Patched undef, "wibble"; };
like $@, qr/\Asubroutine name is not a string/;

eval q{ no Lexical::Sub::Patched '$', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ no Lexical::Sub::Patched 'foo(bar', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ no Lexical::Sub::Patched 'foo::bar', sub{}; };
like $@, qr/\Amalformed subroutine name/;
eval q{ no Lexical::Sub::Patched '!foo', sub{}; };
like $@, qr/\Amalformed subroutine name/;

1;
