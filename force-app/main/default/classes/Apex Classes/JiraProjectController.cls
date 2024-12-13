@RestResource(urlMapping='/JiraProject')
Global class JiraProjectController {
    @httpPost
    Global static void main()
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        system.debug('hello');
        JiraProjectWrapper jiraRequest = JiraProjectWrapper.parse(request.requestBody.toString());
        if (jiraRequest.webhookEvent == 'project_created')
        {
            project__c createProject = new project__c( name = jiraRequest.project.name, description__c = 'hello jazeel', project_id__c = string.valueOf(jiraRequest.project.Id), project_key__c = jiraRequest.project.key );
            insert createProject;
        }
        else if(jiraRequest.webhookEvent == 'project_updated')
        {
            list<project__c> project = JiraProjectSelector.ProjectDetail(String.valueOf(jiraRequest.project.Id));
            
            if(project.size() > 0)
            {
                project[0].name = jiraRequest.project.name;
                update project;
            }
            else
            {
                system.debug('No Project found with this id');
            }
        }
        else if(jiraRequest.webhookEvent == 'project_soft_deleted')
        {
            List<Case> cases = [SELECT Ticket_Key__c FROM Case WHERE Ticket_Key__c LIKE :jiraRequest.project.key + '%'];
            if(cases.size() > 0){
              delete cases;
            }
            list<project__c> project = JiraProjectSelector.ProjectDetail(String.valueOf(jiraRequest.project.Id));
            
            if(project.size() > 0)
            {
                delete project[0];
            }
            else
            {
                system.debug('No Project found with this id');
            }
        }
        
    }
}