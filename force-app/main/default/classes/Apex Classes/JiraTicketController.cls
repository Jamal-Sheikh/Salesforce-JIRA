@RestResource(urlMapping= '/api/JiraIssues')
global without sharing class JiraTicketController {  
    @HttpPost
    global static void Post() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        JiraTicketWrapper jiraRequest = JiraTicketWrapper.parse(request.requestBody.toString());
        
        if (jiraRequest.webhookEvent == 'jira:issue_created') 
        {
            list<project__c> project = JiraTicketSelector.project(jiraRequest.issue.fields.project.id);
            Case caseCreate = new Case( Summary__c = jiraRequest.issue.fields.summary,  Description = jiraRequest.issue.fields.description, Status = jiraRequest.issue.fields.status.name,
                                       Priority = 'Medium',                                                                            
                                       Ticket_Id__c = jiraRequest.issue.id, Origin = 'Jira',	Ticket_Key__c = jiraRequest.issue.key,
                                       Project__c = project[0].id );
            
            if (jiraRequest.issue.fields.assignee != null) {
                list<Employee__c> getEmployees = JiraTicketSelector.employeeToAssigne(jiraRequest.issue.fields.assignee.accountId );
                
                if(getEmployees.isEmpty( )){
                    list<Employee__c> employeeEmail = JiraTicketUtils.employeeEmail(jiraRequest.issue.fields.assignee.accountId);
                    caseCreate.Assignee__c = employeeEmail[0].id;
                }
                else
                {
                    caseCreate.Assignee__c = getEmployees[0].Id;
                }
            }
            else {
                caseCreate.Assignee__c = null;
            }

            if(jiraRequest.issue.fields.duedate != null)
            {
                caseCreate.Due_Date__c = jiraRequest.issue.fields.duedate;  //jiraTicketUtils.convertToDateTime(jiraRequest.issue.fields.timetracking.originalEstimate);
            }
            
            if(JiraRequest.issue.fields.issuetype.subtask == 'true' || JiraRequest.Changelog.Items[0].field == 'IssueParentAssociation'){
                list<case> getRecord = JiraTicketSelector.getParentTicket(jiraRequest.issue.fields.parent.id);
                caseCreate.subtask__c = getRecord[0].id;
            }
            
            insert caseCreate;
        }
        else if(jiraRequest.webhookEvent == 'jira:issue_updated' )
        {
            string value = string.valueOf(JiraRequest.Changelog.Items[0].field);
            list<case> updateCase = JiraTicketSelector.updateTicket(jiraRequest.issue.id);
            if(value == 'summary')
            {
                updateCase[0].Summary__c = jiraRequest.issue.fields.summary;
                update updateCase;
            }
            else if (value == 'Description')
            {
                updateCase[0].Description = jiraRequest.issue.fields.description;
                update updateCase;
            }
            else if(value == 'assignee'){
                if (jiraRequest.issue.fields.assignee != null) {
                    list<Employee__c> employee = JiraTicketUtils.employeeEmail(jiraRequest.issue.fields.assignee.accountId);
                    updateCase[0].Assignee__c = employee[0].id;
                }
                else {
                    updateCase[0].Assignee__c = null;
                }
                update updateCase;
            }
            else if(value == 'duedate'){
               updateCase[0].due_date__c =  jiraRequest.issue.fields.duedate;  //jiraTicketUtils.convertToDateTime(jiraRequest.issue.fields.timetracking.originalEstimate);
               update updateCase;
            }
            else if(value == 'status' || value == 'resolution'){
                updateCase[0].Status = jiraRequest.issue.fields.status.name;
                update updateCase;
            }
            else if(value == 'priority'){
                updateCase[0].Priority = jiraRequest.issue.fields.priority.name;
                update updateCase;
            }
        }
        
        else if(jiraRequest.webhookEvent == 'worklog_created')
        {   
            list<case> getCase = JiraTicketSelector.workLogCreated(jiraRequest.worklog.issueId); //[Select Ticket_Id__c, Assignee__c from case Where Ticket_Id__c =: jiraRequest.worklog.issueId]; // Transfer
            
            if( getCase[0].Assignee__c == null){
                Worklog__c worklogcreate = new Worklog__c(case__c = getCase[0].Id, Worklog_Id__c = jiraRequest.worklog.Id,  Time_Spent__c = decimal.valueOf(jiraRequest.worklog.timeSpentSeconds));
                insert worklogcreate; 
            }
            else{
                Worklog__c worklogcreate = new Worklog__c(case__c = getCase[0].Id, Worklog_Id__c = jiraRequest.worklog.Id, Time_Spent__c = decimal.valueOf(jiraRequest.worklog.timeSpentSeconds), Employee__c = getCase[0].Assignee__c );
                insert worklogcreate; 
            }
        }
        
        else if(jiraRequest.webhookEvent == 'worklog_deleted'){
            list<Worklog__c> getWorklog = JiraTicketSelector.workLogDeleted(jiraRequest.worklog.Id);  //[Select 	Worklog_Id__c from Worklog__c where Worklog_Id__c =:jiraRequest.worklog.Id]; // Transfer
            delete getWorklog;
        }
        
        else if(jiraRequest.webhookEvent == 'worklog_updated'){
            list<Worklog__c> getWorklog = JiraTicketSelector.workLogUpdate(jiraRequest.worklog.Id); //[Select 	Worklog_Id__c, Time_Spent__c from Worklog__c where Worklog_Id__c =:jiraRequest.worklog.Id ]; // Transfer
            getWorklog[0].Time_Spent__c = decimal.valueOf(jiraRequest.worklog.timeSpentSeconds);
            update getWorklog;
        }
          
        else if(jiraRequest.webhookEvent == 'jira:issue_deleted')
        {
            list<case> deleteCase = JiraTicketSelector.deleteTicket(jiraRequest.issue.id);
            list<Worklog__c> getWorklog = JiraTicketSelector.workLogIssuesDelete(deleteCase[0].id);  //[Select 	Worklog_Id__c from Worklog__c where case__c =:deleteCase[0].id]; // Transfer
            delete getWorklog;
            delete deleteCase;
        }
    } 
}