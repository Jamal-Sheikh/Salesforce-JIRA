public with sharing class JiraProjectSyncWrapper {
    
        public String id;
        public String key;
        public String name;
    	
    
    public static list<JiraProjectSyncWrapper> parse(String json) {
        return (list<JiraProjectSyncWrapper>) System.JSON.deserialize(json, List<JiraProjectSyncWrapper>.class);
        
    }
}