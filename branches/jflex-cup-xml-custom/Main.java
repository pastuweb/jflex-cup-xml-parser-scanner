import java.io.*;
import java.util.Hashtable;
import java.util.Set;

public class Main {

	static public void main(String argv[]) {

		try {
			/* Istanzio lo scanner aprendo il file di ingresso argv[0] */
			scanner l = new scanner(new FileReader(argv[0]));
			/* Istanzio il parser */
			parser p = new parser(l);
			/* Avvio il parser */
			Object result = p.parse();
		} catch (Exception e) {
			e.printStackTrace();
		}

		Set<String> keys = parser.symbol_table.keySet();
		for(String key: keys){
			System.out.println("Chiave: "+key+" \n\t\t valore: "+parser.symbol_table.get(key)+"\n");
		}

	}
}