package objects;

public class Time {
	private String start;
	private String end;
	
	// getters
	public String getStartTime(){
		return start;
	}
	
	public String getEndTime(){
		return end;
	}
	
	@Override // overrides tostring function for time
	public String toString(){
		String s = start == null ? "" : start;
		String e = end == null ? "" : end;
		return s + " - " + e;
	}
}
