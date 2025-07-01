@isTest
public with sharing class DailyOppProcessorTest{
    @isTest
    private static void SchedulesApex(){
        List<Opportunity> oppList = new List<Opportunity>();
        String sch = '0 0 0 ? * *'; // cron expression
        for (Integer i = 0; i < 500; i++){
            if (i < 250){
                oppList.add(new Opportunity(Name = 'Test'+ i,
                                            CloseDate = System.today(),
                                            StageName = 'Prospecting'));
            } else {
                oppList.add(new Opportunity(Name = 'Test'+ i,
                                            CloseDate = System.today(),
                                            StageName = 'Prospecting',
                                            LeadSource = 'Other'));
            }
        }
        insert oppList;

        Test.startTest();
        String jobId = System.schedule('Process Opportunities', sch, new DailyOppProcessor());
        Test.stopTest();

        List<Opportunity> updateOppList = [SELECT Id, LeadSource FROM Opportunity WHERE LeadSource = 'Web'];
        System.assertEquals(200, updateOppList.size());
    }
}