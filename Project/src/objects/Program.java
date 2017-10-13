package objects;

import java.util.ArrayList;
import java.util.List;

public class Program {
	private List<File> files;
	
	// constructor to initialize dynamically allocated lists
	public Program(){
		files = new ArrayList<>();
	}
	
	// getters
	public List<File> getFiles(){
		return files;
	}
}
