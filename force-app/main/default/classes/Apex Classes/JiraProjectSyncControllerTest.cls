@isTest 
public class JiraProjectSyncControllerTest {
    
    @isTest 
static void testPostCallout() {
    
    Test.setMock(HttpCalloutMock.class, new JiraProjectSyncControllerMock()); 
 
    JiraProjectSyncController.fetchAndCreateProjectRecords();
    project__c project = [select name , project_key__c, project_id__c from project__c where project_id__c = '10000' ];
    System.assertEquals('10000', project.Project_Id__c);

}

}