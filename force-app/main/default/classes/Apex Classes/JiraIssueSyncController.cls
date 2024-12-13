public without sharing class JiraIssueSyncController {
    @InvocableMethod
    public static void createCaseRecords() {
      
       list<JiraConfig__mdt> getRecords = JiraConfigration.metaRecords( );
        String JIRA_BASE_URL = getRecords[0].BaseUrl__c;
        String JIRA_USERNAME = getRecords[0].UserName__c;
        String JIRA_API_TOKEN = getRecords[0].Token__c;

        String jiraApiUrl = JIRA_BASE_URL + '/rest/api/2/search';
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(jiraApiUrl);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(JIRA_USERNAME + ':' + JIRA_API_TOKEN)));
        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            
            JiraIssuesWrapper jiraIssues = JiraIssuesWrapper.parse(response.getBody());
            List<Case> casesToInsert = new List<Case>();
            LIST<case> listToUpdate = new list<case>();
            
            map<string , string > parentTicket = new map<string , string >();
       		map<string , string > parentIdWithRecordId = new map<string , string >();
            map<string , string > parentIdWithChildId = new map<string , string >();
            
            Set<String> projectIds = new Set<String>();
            Set<String> ParentTicketIds = new Set<String>();
            
            for (JiraIssuesWrapper.Issue issue : jiraIssues.issues) {
                projectIds.add(issue.fields.project.id);
            }
            Map<String, Project__c> projectMap = JiraIssueSyncSelector.projectMap(projectIds);
            
            Set<String> ticketIds = new Set<String>();
            for (JiraIssuesWrapper.Issue issue : jiraIssues.issues) {                  
                ticketIds.add(issue.id);
            }
            Map<String, Case> existingCasesMap = JiraIssueSyncSelector.existingCasesMap(ticketIds);    
            List<String> accountIds = new List<String>();
            for (JiraIssuesWrapper.Issue issue : jiraIssues.issues) {
                if (issue.fields.assignee != null) {
                    accountIds.add(issue.fields.assignee.accountId);
                }
            }
            Map<String, Employee__c> employeeMap = new Map<String, Employee__c>();
            List<Employee__c> employeeList = JiraIssueSyncSelector.employeeList(accountIds);
            for (Employee__c employee : employeeList) {
                employeeMap.put(employee.jira_user_id__c, employee);
            }

            for (JiraIssuesWrapper.Issue issue : jiraIssues.issues) {
                if (!existingCasesMap.containsKey(issue.id)) {
                    
                    
                    Case newCase = new Case();
              
                    
                    if(issue.fields.parent != null){
                      ParentTicketIds.add(issue.fields.parent.id);
                      parentIdWithChildId.put(issue.id , issue.fields.parent.id);
                      
                    }
                    newCase.Origin = 'Jira';
                    newCase.Ticket_ID__c = issue.id;

                    newCase.Status = issue.fields.status.name;
                    newCase.Priority = issue.fields.priority.name;
                    newCase.Summary__c = issue.fields.summary;
                    newCase.Ticket_Key__c = issue.key;
                    newCase.Description = issue.fields.description;
                    newCase.Project_ID__c = issue.fields.project.id;
                    if (issue.fields.assignee != null) {
                        String jiraAssigneeName = issue.fields.assignee.accountId;
                        if (employeeMap.containsKey(jiraAssigneeName)) {
                            newCase.Assignee__c = employeeMap.get(jiraAssigneeName).Id;

                        } else {
                            newCase.Assignee__c = null; // Set a default value or handle as needed
                            
                        }
                    }
                    if (projectMap.containsKey(issue.fields.project.id)) {
                        newCase.Project__c = projectMap.get(issue.fields.project.id).Id;
                    }
                    casesToInsert.add(newCase);

                }
            }
            if (!casesToInsert.isEmpty()) {

                insert casesToInsert;
            }
            
            list<case> parentIdsForMap = [select ticket_id__c from case where ticket_id__c in :ParentTicketIds ];
            
            for(case parentToAdd : parentIdsForMap)
            {
                parentIdWithRecordId.put(parentToAdd.ticket_id__c , parentToAdd.id );
            }
       
            list<case> childsToUpdate = [select ticket_id__c, Subtask__c from case where ticket_id__c in :parentIdWithChildId.keySet()];
            
            for(case updateRecord : childsToUpdate)
            {
               String parentId = parentIdWithChildId.get(updateRecord.ticket_id__c);
               updateRecord.Subtask__c = parentIdWithRecordId.get(parentId);
               listToUpdate.add(updateRecord);
            }
            
            if(!listToUpdate.isEmpty()){

                update listToUpdate;
            }
            
        }
    }
}