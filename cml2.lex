%%
%init{
    yybegin(s1);
%init}

%type Symbol 
%class cmlScanner 
%state s1, sc

%%
<s1>"/*" {yybegin(COMMENT);}
<sc>"*/" {yybegin(YYINITIAL);}
<s1>"//[^\r\n]*[\r\n]" {System.out.println("comment"); return new Symbol(cmlSymbol.COMMENT);}
<s1>"import [a-zA-Z][a-zA-Z0-9]*;" {System.out.println("import"); return new Symbol(cmlSymbol.IMPORT_STMT);}
