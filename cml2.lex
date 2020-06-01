import java_cup.runtime.*;

%%
%init{
    yybegin(init);
%init}


%implements java_cup.runtime.Scanner
%type Symbol
%function next_token
%class cmlScanner
%state init, comm, param, param2

IMPORT = import[\040\r\n]*[a-zA-Z][a-zA-Z0-9]*[;]
WHITE_SP = [\040\r\n]

%%

<init>"/*" {System.out.println("multi-comm start");yybegin(comm);}
<comm>"*/" {System.out.println("multi-comm end");yybegin(init); }
<init>//[^\r\n]*[\r\n] {System.out.println("single-line comm");}
<init>{IMPORT} {System.out.println("import");return new Symbol(cmlSymbol.IMPORT, yytext());}
<init>[a-zA-Z][a-zA-Z0-9]*{WHITE_SP}*\{ {System.out.println("empty block start");return new Symbol(cmlSymbol.EMPTY_BLOCK_START, yytext());}
<init>[a-zA-Z][a-zA-Z0-9]*{WHITE_SP}*\( {System.out.println("param start");yybegin(param); return new Symbol(cmlSymbol.PARAM_START, yytext());}
<param>[a-zA-Z][a-zA-Z0-9]* {System.out.println("id");return new Symbol(cmlSymbol.ID, yytext());}
<param>"=" {System.out.println("equals");return new Symbol(cmlSymbol.EQUALS);}
<param>\"[^\"]*\" {System.out.println("idValue");return new Symbol(cmlSymbol.IDVALUE, yytext());}
<param>"," {System.out.println("separator");return new Symbol(cmlSymbol.SEPARATOR);}
<param>")" {System.out.println("param end");yybegin(param2); return new Symbol(cmlSymbol.PARAM_END);}
<param2>";" {System.out.println("param empty");yybegin(init); return new Symbol(cmlSymbol.PARAM_EMPTY);}
<param2>"{" {System.out.println("block start");yybegin(init); return new Symbol(cmlSymbol.BLOCK_START);}
<init>"}" {System.out.println("block end");return new Symbol(cmlSymbol.BLOCK_END);}
{WHITE_SP} {System.out.println("white space");}
<init>[^\040\r\n\{\}\(\)]* {System.out.println("text: " + yytext());return new Symbol(cmlSymbol.TEXT, yytext());}
. {System.out.println("nothing");}

