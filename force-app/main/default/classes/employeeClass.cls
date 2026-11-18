public class employeeClass{
    public static Map<String, List<String>> userEmployee(String department){
        List<Employee__c> employees = [
            SELECT Department__c, Employee_user__r.Name
            FROM Employee__c  
        ];
        List<String> users = new List<String>();
        for(Employee__c emp : employees){
            if(emp.Department__c == department){
                users.add(emp.Employee_User__r.Name);
            }  
        }
            Map<String, List<String>> deptUsers = new map<String, List<String>>();
            deptUsers.put(department,users);
            
        return deptUsers;
        
    } 
}