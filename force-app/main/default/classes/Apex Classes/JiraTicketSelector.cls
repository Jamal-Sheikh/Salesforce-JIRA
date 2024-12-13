public class JiraTicketSelector { 
    
    public static list<project__c> project(String projectId)
    {
        list<project__c> project = [select name, project_key__c, project_id__c from project__c where project_id__c =: projectId];
        return project;
    }
    public static list<Employee__c> employeeToAssigne(String accountId)
    {
        list<Employee__c> getEmployees = [Select Id, Name, Email__c, Mobile__c, Password__c, Jira_user_Id__c, UserName__c,Designation__c From Employee__c
                                          Where Jira_user_Id__c =: accountId ];
        return getEmployees;
    }
    public static list<case> getParentTicket(String accountId)
    {
        list<case> parentTicket = [Select Ticket_Id__c, Summary__c, Assignee__c, Description, Status, Priority, Original_estimate__c from case
                                   Where Ticket_Id__c =: accountId];
        return parentTicket;
    }
    public static list<case> updateTicket(String TicketId)
    {
        list<case>  updateCase = [Select Ticket_Id__c, Ticket_Key__c, Summary__c, due_date__c, Assignee__c,  Description, Status, Priority, Original_estimate__c
                                  from case WHERE Ticket_Id__c = :TicketId ];
        return updateCase;
    }
    
    
    public static list<case> deleteTicket(String ticketID)
    {
        list<case> deleteCase = [Select Ticket_Id__c, Ticket_Key__c, Summary__c, Assignee__c,  Description, Status, Priority, Original_estimate__c from case
                                 WHERE Ticket_Id__c = :ticketID];
        return deleteCase;
    } 
    
    public static list<case> workLogCreated(String issueID)
    {
        list<case> getCase = [Select Ticket_Id__c, Assignee__c from case Where Ticket_Id__c =: issueID];
        return getCase;
    } 
    
    public static list<Worklog__c> workLogDeleted(String worklogId)
    {
        list<Worklog__c> getWorklog = [Select 	Worklog_Id__c from Worklog__c where Worklog_Id__c =:worklogId]; 
        return getWorklog;
    } 
    
    public static list<Worklog__c> workLogUpdate(String worklogId)
    {
        list<Worklog__c> getWorklog = [Select 	Worklog_Id__c, Time_Spent__c from Worklog__c where Worklog_Id__c =:worklogId ]; 
        return getWorklog;
    } 
    
        public static list<Worklog__c> workLogIssuesDelete(String ticketId)
    {
        list<Worklog__c> getWorklog = [Select 	Worklog_Id__c, Time_Spent__c from Worklog__c where Worklog_Id__c =:ticketId ]; 
        return getWorklog;
    } 
}