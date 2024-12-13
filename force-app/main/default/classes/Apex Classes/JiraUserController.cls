public with sharing class JiraUserController {
    @invocableMethod
     public static void getAllUsers(){
     {         
        list<JiraConfig__mdt> getRecords = JiraConfigration.metaRecords( );
        String JIRA_BASE_URL = getRecords[0].BaseUrl__c;
        String JIRA_USERNAME = getRecords[0].UserName__c;
        String JIRA_API_TOKEN = getRecords[0].Token__c;
         
        HttpRequest getUser = new HttpRequest();
        getUser.setEndpoint(JIRA_BASE_URL + '/rest/api/2/users/search');
        getUser.setMethod('GET');
        getUser.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(JIRA_USERNAME + ':' + JIRA_API_TOKEN)));
        Http http = new Http();
        HttpResponse getUserResponse = http.send(getUser);
        list<JiraUserWrapper> jiraUserResponse = JiraUserWrapper.parse(string.valueOf(getUserResponse.getBody()));
        map<string,string> jsonMap = new map<string,string>();
        for (JiraUserWrapper userData : jiraUserResponse)
        {
            if(userData.accountType == 'atlassian')
            {
                jsonMap.put(userData.emailAddress , userData.accountId );
            }
        }
        // CODE TO CHECK AND UPDATE IF JIRA USER ID IS NULL
        list<employee__c > employees = JiraUserSelector.employees();
        list<employee__c> employeeList = new list<employee__c>();
        for(employee__c employee : employees)
        {
            if(employee.jira_user_id__c == null)
            {
                employee.jira_user_id__c = jsonMap.get(employee.Email__c);
                employeeList.add(employee);
            }
        }
      
        update employeeList;
}
}
}