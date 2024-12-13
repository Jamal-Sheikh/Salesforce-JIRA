public class JiraProjectSelector {
    public static list<project__c> projectDetail(String jiraId)
    {
        list<project__c> project = [select name , project_key__c, project_id__c from project__c where project_id__c =: jiraId ];
        return project;
    }
}