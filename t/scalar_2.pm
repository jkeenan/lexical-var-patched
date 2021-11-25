use strict;
use Lexical::Var::Patched '$foo' => \(my$x=2);
push @main::values, $foo;
1;
