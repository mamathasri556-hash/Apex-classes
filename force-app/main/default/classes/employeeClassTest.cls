@isTest
public class employeeClassTest {

    @isTest
    static void testUserEmployee() {

        Employee__c emp = new Employee__c(
            Department__c = 'IT'
        );
        insert emp;

        Test.startTest();
        Map<String, List<String>> result = employeeClass.userEmployee();
        Test.stopTest();

        System.assert(result.containsKey('IT'));
    }
}