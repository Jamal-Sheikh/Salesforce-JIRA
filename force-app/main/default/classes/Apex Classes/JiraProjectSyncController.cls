public with sharing class JiraProjectSyncController {
    @InvocableMethod
    public static void fetchAndCreateProjectRecords() {
        
        
        list<JiraConfig__mdt> getRecords = JiraConfigration.metaRecords( );
        String JIRA_BASE_URL = getRecords[0].BaseUrl__c;
        String JIRA_USERNAME = getRecords[0].UserName__c;
        String JIRA_API_TOKEN = getRecords[0].Token__c;
        
        
        
        HttpRequest projectsRequest = new HttpRequest();
        projectsRequest.setEndpoint(JIRA_BASE_URL + '/rest/api/2/project');
        projectsRequest.setMethod('GET');
        projectsRequest.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(JIRA_USERNAME + ':' + JIRA_API_TOKEN)));
        Http http = new Http();
        HttpResponse response = http.send(projectsRequest);
        if (response.getStatusCode() == 200) {
            list<JiraProjectSyncWrapper> projectResponse = JiraProjectSyncWrapper.parse(response.getBody());
            system.debug(response.getBody());
            List<Project__c> projectRecords = new List<Project__c>();
            Set<String> existingprojectIds = JiraProjectSyncSelector.existingProjectIds();
            for (JiraProjectSyncWrapper projectDetail : projectResponse) {
                String projectId = projectDetail.id;
                if (!existingProjectIds.contains(projectId)) {
                    Project__c newProject = new Project__c();
                    newProject.project_id__c = projectId;
                    newProject.Name = projectDetail.name;
                    newProject.project_key__c = projectDetail.key;
                   
                    
                    projectRecords.add(newProject);
                    
                }
            }
            if (!projectRecords.isEmpty()) {
                insert projectRecords;
                
                
            }
        } else {
            System.debug('Jira API Request for Projects Failed. Status Code: ' + response.getStatusCode());
            System.debug('Response Body: ' + response.getBody());
        }
    }
}