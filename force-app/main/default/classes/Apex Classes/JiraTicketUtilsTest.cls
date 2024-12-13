@istest
public class JiraTicketUtilsTest {
        @isTest 
static void testPostCallout() {
 
    Test.setMock(HttpCalloutMock.class, new JiraTicketUtilsMock()); 
    JiraTicketUtils.employeeEmail('712020:ab945a13-4886-4e14-8bf0-4a523ab84336');
    
}

}