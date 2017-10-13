package parsing;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import com.google.gson.Gson;

import objects.DataContainer;

public class Parser {
	// school container object
	private DataContainer data;
	
	// constructor to parse with filename (takes file and converts to bufferedreader)
	public Parser(String filename) throws IOException{
		BufferedReader bf = new BufferedReader(new FileReader(filename));
		Gson gson = new Gson();
		data = gson.fromJson(bf, DataContainer.class);
	}
	
	// constructor overload to parse directly with buffered reader
	public Parser(BufferedReader bf) throws IOException{
		Gson gson = new Gson();
		data = gson.fromJson(bf, DataContainer.class);
	}
	
	// getters
	public DataContainer getData(){ return data; }
}
