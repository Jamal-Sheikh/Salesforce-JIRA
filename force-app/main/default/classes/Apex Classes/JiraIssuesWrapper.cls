public class JiraIssuesWrapper {
    public Long timestamp;
    public String webhookEvent;
    public User user;
    public List<Issue> issues;  // Changed to a list of issues
    public class User {
        public String self;
        public String accountId;
        public String displayName;
        public Boolean active;
        public String timeZone;
        public String accountType;
    }
    public class Issue {
        public String id;
        public String self;
        public String key;
        public Fields fields;
    }
    public class Fields {
        public String summary;
        public String description;
        public String originalEstimate;
        public String customfield_10008;
        public String customfield_10009;
        public Assignee assignee;
        public Timetracking timetracking;
        public Priority priority;
        public Status status;
        public Project project;
        public string subtask;
        public Issuetype issuetype;
        public parent parent;
    }
    public class Project {
		public String self;
		public String id;
		public String key;
		public String name;
		
	}
    public class Assignee {
        public String displayName;
        public string accountId;
    }
    public class Timetracking {
        public String originalEstimate;
    }
    public class Priority {
        public String name;
    }
    public class Comment {
        public String body;
    }
    public class Status{
        public string name;
    }
    public class issuetype {
        public string subtask;
    }
    public class parent{
        public string key;
        public string id;
    }
    public static JiraIssuesWrapper parse(String json) {
        return (JiraIssuesWrapper) System.JSON.deserialize(json, JiraIssuesWrapper.class);
    }
}