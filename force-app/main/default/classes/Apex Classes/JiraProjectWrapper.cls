public class JiraProjectWrapper {
	public class Project {
		public String self;
		public Integer Id;
		public String key;
		public String name;
		public String assigneeType;
	}
	public Long timestamp;
	public String webhookEvent;
	public Project project;
    public static JiraProjectWrapper parse(String json)
    {
        return (JiraProjectWrapper) System.JSON.deserialize(json, JiraProjectWrapper.class);
    }
}