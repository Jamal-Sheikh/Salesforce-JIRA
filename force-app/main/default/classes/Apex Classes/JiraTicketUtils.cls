public without sharing class JiraTicketUtils {
           
    public static list<Employee__c> employeeEmail(String accountId)
    {
        list<JiraConfig__mdt> getRecords = JiraConfigration.metaRecords( );
        String JIRA_BASE_URL = getRecords[0].BaseUrl__c;
        String JIRA_USERNAME = getRecords[0].UserName__c;
        String JIRA_API_TOKEN = getRecords[0].Token__c;
        
        HttpRequest userEmailRequest = new HttpRequest();
        userEmailRequest.setEndpoint(JIRA_BASE_URL + '/rest/api/3/user?accountId='+accountId+'');
        userEmailRequest.setMethod('GET');
        userEmailRequest.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(JIRA_USERNAME + ':' + JIRA_API_TOKEN)));
        Http http = new Http();
        HttpResponse userEmailResponse = http.send(userEmailRequest);
        JiraTicketWrapper jiraRequest = JiraTicketWrapper.parse(String.valueOf(userEmailResponse.getBody( )));

        string email = jiraRequest.emailAddress;

        list<Employee__c> employee = new List<Employee__c>();
        employee  = [Select Id, Name, Email__c, Mobile__c, Password__c, UserName__c, Designation__c From Employee__c WHERE Email__c = :email];
		if(employee.size() > 0)
        {
        employee[0].Jira_user_Id__c = accountId;
        update employee;
        return employee;
        }
        else{
            return employee;
        }
    }
   
    

    
    
}