public with sharing class JiraConfigration {
    public static list<JiraConfig__mdt> metaRecords( ){
        list<JiraConfig__mdt> getRecords = [Select BaseUrl__c, Token__c, UserName__c from JiraConfig__mdt];
        return getRecords;
    }
}