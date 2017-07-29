/*****************************************************************************************
Created By: Prasheela MP
Description: Test clas for ErrorLogClass
******************************************************************************************/  @isTest
public class ErrorLogClassTest{
    static testMethod void errorLog(){
         User usr = Utility.createUserRecord();
         System.runAs(usr){
            
            Test.startTest();//Starts the scope of test
                try{
                    lead ld =new Lead();
                    ld.CreatedById= usr.Id;
                    Insert ld;
                }
                catch(Exception error){
                      ErrorLogClass.logError('ClassName', error,'methodName');
                }
             
            Test.stopTest();   
        }  
    }
}