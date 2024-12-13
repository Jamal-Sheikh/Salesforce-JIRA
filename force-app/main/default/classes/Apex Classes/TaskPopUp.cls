public with sharing class TaskPopUp {
    @AuraEnabled
    public static void createTask(Date getDate, string getId ){
      
     task taskRecord = [Select Id, Status, Subject, Priority, ActivityDate, WhatId from Task where Id =:getId];

     task createNewTask =  new task(Subject = taskRecord.Subject, Status = 'Not Started', Priority = taskRecord.Priority, WhatId = taskRecord.WhatId,
     ActivityDate = getDate);
     
     insert createNewTask;
     

    }
}