public with sharing class JiraProjectSyncSelector {
    public static Set<String> existingProjectIds() {
        Set<String> existingProjectIds = new Set<String>();
        for (Project__c existingProject : [SELECT project_id__c FROM Project__c]) {
            existingProjectIds.add(existingProject.project_id__c);
        }
        return existingProjectIds;
    }
}