package t::setup_c_7;
sub import { "Lexical::Var::Patched"->import('&t7' => sub{123}); }
1;
