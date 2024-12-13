public class JiraTicketWrapper {
    public Long timestamp;
    public String webhookEvent;
    public User user;
    public Issue issue;
    public String assignee;
    public Changelog changelog;
    public  Worklog worklog;
    public string emailAddress;
    public List<Issue> issues;
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
        public  String originalEstimate;
        public Assignee assignee;
        public Timetracking timetracking;
        public Priority priority;
        public Status status;
        public Resolution resolution;
        public Parent parent;
        public Project project;
        public IssueType issuetype;
        public string timeoriginalestimate;
        public date duedate;
    }
    public class IssueType{
        public string subtask;
    }
    Public class Project {
        public string key;
        public string id;
        public string name;
    }
    public class Parent{
        public string id;
        public string key;
    }
    Public class Assignee{
        public string displayName;
        public string accountId;
    }
    public class Status{
        public string name;
    }
    public class Resolution{
        public string name;
    }
    Public class Timetracking{
        public string originalEstimate;
        public string originalEstimateSeconds;
    }
    Public class Priority{
        public string name;
    }
    public class Comment{
        Public string body;
    }
    Public class Changelog {
        public List<Items> items;
    }
    public class items{
        public string field;	
    }
    public class worklog{
        public string timeSpent;
        public string issueId;
        public string timeSpentSeconds;
        public string Id;
    }
    


    public static JiraTicketWrapper parse(String json) {
        return (JiraTicketWrapper) System.JSON.deserialize(json, JiraTicketWrapper.class);
    }
}