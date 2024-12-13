public with sharing class JiraIssueSyncSelector {
    
    public static  Map<String, Case> existingCasesMap(Set<String> ticketIds){
        Map<String, Case> existingCasesMap = new Map<String, Case>();
        for (Case existingCase : [SELECT Id, Ticket_ID__c FROM Case WHERE Ticket_ID__c IN :ticketIds]) {
            existingCasesMap.put(existingCase.Ticket_ID__c, existingCase);
        }
        return existingCasesMap;
    }
    public static  Map<String, Project__c> projectMap(Set<String> projectIds){
        Map<String, Project__c> projectMap = new Map<String, Project__c>();
        for (Project__c project : [SELECT Id, Project_Id__c FROM Project__c WHERE Project_Id__c IN :projectIds]) {
            projectMap.put(project.Project_Id__c, project);
        }
        return ProjectMap;
    }
    public static  List<Employee__c> employeeList(List<String> accountIds){
        List<Employee__c> employeeList = [SELECT Id, Name, jira_user_id__c FROM Employee__c WHERE jira_user_id__c IN :accountIds];
        return employeeList;
    }
      public static  List<case> childList(List<String> listId){
        list<case> childList = [select Ticket_key__c from case where Ticket_key__c IN :listId ];
          return childList;
       }
}