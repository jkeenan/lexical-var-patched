use Lexical::Var::Patched '&foo' => sub { 2 };
push @main::values, &foo;
1;
