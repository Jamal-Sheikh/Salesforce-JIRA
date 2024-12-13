@istest public class JiraUserControllerTest {
    
@isTest 
static void testPostCallout() {
    
    Test.setMock(HttpCalloutMock.class, new JiraUserControllerMock()); 
    JiraUserController.getAllUsers();
    
}

}