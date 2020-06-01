java JLex.Main cml2.lex
java java_cup.Main -parser cmlParser -symbols cmlSymbol cml.cup 
javac cml2.lex.java
javac cmlParser.java cmlSymbol.java cmlUser.java
java cmlUser
