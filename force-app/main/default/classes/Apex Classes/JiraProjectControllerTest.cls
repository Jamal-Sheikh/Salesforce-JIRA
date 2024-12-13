@istest
public class JiraProjectControllerTest {
    
   @istest   public static void main(){
        RestRequest request = new RestRequest();
     
        RestContext.request = request;

        request.requestURI = 'https://cloud146-dev-ed.develop.my.salesforce-sites.com/services/apexrest/JiraProject';
       
        blob body = Blob.valueof(' { "timestamp": 1703845825242, "webhookEvent": "project_created", "project": { "self": "https://farhan123.atlassian.net/rest/api/2/project/10046", "id": 10046, "key": "SP", "name": "Salesforce Project", "avatarUrls": { "48x48": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412", "24x24": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=small", "16x16": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=xsmall", "32x32": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=medium" }, "projectLead": { "self": "https://farhan123.atlassian.net/rest/api/2/user?accountId=712020%3Aad65b8fb-f0b7-4e9b-b216-921dc4ef6489", "accountId": "712020:ad65b8fb-f0b7-4e9b-b216-921dc4ef6489", "emailAddress": "farhanjaved.9444@gmail.com", "avatarUrls": { "48x48": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "24x24": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "16x16": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "32x32": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png" }, "displayName": "Farhan Javed", "active": true, "timeZone": "Asia/Karachi", "accountType": "atlassian" }, "assigneeType": "admin.assignee.type.unassigned" } }');
        request.requestBody = body;
        
        JiraProjectController.main();
        project__c project = [select name , project_key__c, project_id__c from project__c where project_id__c = '10046' ];
        string expectedId = '10046';
        System.assertEquals(expectedId, project.project_id__c);
       
       //For Update Test
        request.requestURI = 'https://cloud146-dev-ed.develop.my.salesforce-sites.com/services/apexrest/JiraProject';
        
        blob body1 = Blob.valueof('{ "timestamp": 1703846033345, "webhookEvent": "project_updated", "project": { "self": "https://farhan123.atlassian.net/rest/api/2/project/10046", "id": 10046, "key": "SP", "name": "SalesforceCloud Project", "avatarUrls": { "48x48": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412", "24x24": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=small", "16x16": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=xsmall", "32x32": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=medium" }, "projectLead": { "self": "https://farhan123.atlassian.net/rest/api/2/user?accountId=712020%3Aad65b8fb-f0b7-4e9b-b216-921dc4ef6489", "accountId": "712020:ad65b8fb-f0b7-4e9b-b216-921dc4ef6489", "emailAddress": "farhanjaved.9444@gmail.com", "avatarUrls": { "48x48": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "24x24": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "16x16": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "32x32": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png" }, "displayName": "Farhan Javed", "active": true, "timeZone": "Asia/Karachi", "accountType": "atlassian" }, "assigneeType": "admin.assignee.type.unassigned" } }');
        request.requestBody = body1;
        
        JiraProjectController.main();
        project__c project1 = [select name , project_key__c, project_id__c from project__c where project_id__c = '10046' ];
            
        string expectedName = 'SalesforceCloud Project';
        
        System.assertEquals(expectedName, project1.name);
       
     
       //For Delete Project
       request.requestURI = 'https://cloud146-dev-ed.develop.my.salesforce-sites.com/services/apexrest/JiraProject';
        
        blob deleteProject = Blob.valueof('{ "timestamp": 1703847045088, "webhookEvent": "project_soft_deleted", "project": { "self": "https://farhan123.atlassian.net/rest/api/2/project/10046", "id": 10046, "key": "SP", "name": "SalesforceCloud Project", "avatarUrls": { "48x48": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412", "24x24": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=small", "16x16": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=xsmall", "32x32": "https://farhan123.atlassian.net/rest/api/2/universal_avatar/view/type/project/avatar/10412?size=medium" }, "projectLead": { "self": "https://farhan123.atlassian.net/rest/api/2/user?accountId=712020%3Aad65b8fb-f0b7-4e9b-b216-921dc4ef6489", "accountId": "712020:ad65b8fb-f0b7-4e9b-b216-921dc4ef6489", "emailAddress": "farhanjaved.9444@gmail.com", "avatarUrls": { "48x48": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "24x24": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "16x16": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png", "32x32": "https://secure.gravatar.com/avatar/c2eee5f20104dab1c080675f115b0577?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FFJ-5.png" }, "displayName": "Farhan Javed", "active": true, "timeZone": "Asia/Karachi", "accountType": "atlassian" }, "assigneeType": "admin.assignee.type.unassigned" } } }');
        request.requestBody = deleteProject;
        
        JiraProjectController.main();
       
    }
}