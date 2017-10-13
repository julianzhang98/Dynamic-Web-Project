package objects;

public class TimePeriod {
	private String day;
	private Time time;
	
	// getters
	public String getDay(){
		return day;
	}
	
	public Time getTime(){
		return time;
	}
	
	@Override // overrides tostring function for time
	public String toString(){
		return day + (time == null ? "" : " " + time.toString());
	}
}
