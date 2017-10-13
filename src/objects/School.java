package objects;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class School {
	private String name;
	private String image;
	private List<Department> departments;
	//menu to print for departments
	private String departmentsMenu;
	//valid integer inputs for this menu
	private Set<Integer> menuOptions;
	
	// constructor to initialize dynamically allocated lists
	public School(){
		departments = new ArrayList<>();
	}
	
	// getters
	public String getName(){
		return name;
	}
	
	public String getImage(){
		return image;
	}
	
	public List<Department> getDepartments(){
		return departments;
	}
	
	// IGNORE FUNCTIONS BELOW
	public void setDepartmentsMenu(String menu){
		this.departmentsMenu = menu;
	}
	
	public String getDepartmentsMenu(){
		return departmentsMenu;
	}
	
	public Set<Integer> getMenuOptions(){
		return menuOptions;
	}
	
	public void setMenuOptions(Set<Integer> menuOptions){
		this.menuOptions = menuOptions;
	}
	
}
