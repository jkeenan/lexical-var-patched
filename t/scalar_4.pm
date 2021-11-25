use strict;
no Lexical::Var::Patched '$foo';
push @main::values, $foo;
1;
