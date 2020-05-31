import java.io.*;

%%

%{
  // this is a tester program, not meant for production. try cml2.
  public static void main(String [] args) throws java.io.IOException {
    cml lexer=new cml(new FileReader("index.cml"));
    String t;
    int nums[] = new int[5];
    while ((t=lexer.yylex())!=null) {
      System.out.println(t);
    }
  }
%}

%init{
  yybegin(init);
%init}
%line
%type String
%class cml 
%eofval{ return null;
%eofval}
%state init, comm, param, param2

IMPORT = import[\040\r\n]*[a-zA-Z][a-zA-Z0-9]*[;]
WHITE_SP = [\040\r\n]

%%
<init>"/*" {yybegin(comm);}
<comm>"*/" {yybegin(init); return "comment";}
<init>//[^\r\n]*[\r\n] {return "comment";}
<init>{IMPORT} {return "import";}
<init>[a-zA-Z][a-zA-Z0-9]*{WHITE_SP}*\{ {return "emptyBlockStart";}
<init>[a-zA-Z][a-zA-Z0-9]*{WHITE_SP}*\( {yybegin(param); return "paramStart";}
<param>[a-zA-Z][a-zA-Z0-9]* {return "id";}
<param>"=" {return "equals";}
<param>\"[^\"]*\" {return "idValue";}
<param>"," {return "separator";}
<param>")" {yybegin(param2); return "paramEnd";}
<param2>";" {yybegin(init); return "paramEmpty";}
<param2>"{" {yybegin(init); return "blockStart";}
<init>"}" {return "blockEnd";}
{WHITE_SP} {}
<init>[^\040\r\n\{\}\(\)]* {return "text: " + yytext();}
. {}
