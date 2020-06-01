import java.io.*; 
import java_cup.runtime.Symbol; 
class cmlUser { 
    public static void main(String[] args) throws Exception { 
        System.out.println("program starting...");
        File inputFile = new File ("basic.cml"); 
        cmlParser parser= new cmlParser(new cmlScanner(new FileInputStream(inputFile))); 
        String htmlFile =(String)parser.parse().value; 
        FileWriter fw=new FileWriter(new File("basic.html")); 
        fw.write(htmlFile); 
        fw.close(); 
    } 
} 