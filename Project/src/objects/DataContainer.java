package objects;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class DataContainer {
	private List<School> schools;
	//menu to print
	private String schoolsMenu;
	//valid inputs for that menu
	private Set<Integer> menuOptions;
	
	// constructor to initialize dynamically allocated lists
	public DataContainer(){
		schools = new ArrayList<>();
	}
	
	public List<School> getSchools(){
		return schools;
	}
	
	
	// IGNORE FUNCTIONS BELOW
	public String getSchoolsMenu(){
		return schoolsMenu;
	}
	
	public void setSchoolsMenu(String menu){
		this.schoolsMenu = menu;
	}
	
	public Set<Integer> getMenuOptions(){
		return menuOptions;
	}
	
	public void setMenuOptions(Set<Integer> menuOptions){
		this.menuOptions = menuOptions;
	}
}
