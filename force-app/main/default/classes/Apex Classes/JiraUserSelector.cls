public class JiraUserSelector {
    public static List<Employee__c> employees(){
        list<employee__c > employees = [ select name , email__c , jira_user_id__c from employee__c];
        return employees;
    }
}