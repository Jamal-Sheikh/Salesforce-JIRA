@isTest
public with sharing class TaskPopUpTest {

    @isTest public static void testTaskPopUp()
    {
        task createNewTask =  new task(Subject = 'taskRecord', Status = 'Completed', Priority = 'Normal', ActivityDate = Date.today());
        insert createNewTask;

        TaskPopUp.createTask(Date.today(),createNewTask.Id);
        
        createNewTask.Status = 'Completed';
        update createNewTask;

    }
}