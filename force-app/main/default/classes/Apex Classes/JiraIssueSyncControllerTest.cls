@istest public class JiraIssueSyncControllerTest {
    
            @isTest 
static void testPostCallout() {
    
    Test.setMock(HttpCalloutMock.class, new JiraIssueSyncControllerMock()); 
 	JiraIssueSyncController.createCaseRecords();
    


}

}