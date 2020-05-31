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
      if (t.equals("ID")) nums[0]++;
      if (t.equals("KEYWORD")) nums[1]++;
      if (t.equals("NUM")) nums[2]++;
      if (t.equals("COMMENT")) nums[3]++;
      if (t.equals("STRING")) nums[4]++;
    }
    System.out.println("identifiers: "+nums[0]+
                       "\nkeywords: "+nums[1]+
                       "\nnumbers: "+nums[2]+
                       "\ncomments:"+nums[3]+
                       "\nquotedString:"+nums[4]);
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
