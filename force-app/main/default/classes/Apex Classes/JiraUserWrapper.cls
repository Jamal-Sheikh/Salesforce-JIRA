public class JiraUserWrapper {
      public string webhookEvent;
        public String self;
        public String accountId;
        public String accountType;
        public String emailAddress;
        public String displayName;
        public Boolean active;
        public String locale;
    	public User user;
    public class User {
        public String emailAddress;
        public String accountId;
    }
           public static JiraUserWrapper parseSingle(String json) {
            return (JiraUserWrapper) System.JSON.deserialize(json, JiraUserWrapper.class);
        }
        public static List<JiraUserWrapper> parse(String json) {
            return (List<JiraUserWrapper>) System.JSON.deserialize(json, List<JiraUserWrapper>.class);
        }
}