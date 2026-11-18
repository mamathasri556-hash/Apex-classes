/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : Message
 * Author          : <YourName>
 * Created Date    : Sep 24, 2026
 * Last Modified By: <YourName>
 * Last Modified On: Sep 24, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Sep 24, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

public class MessageController {

    @AuraEnabled(cacheable=true)
    public static List<Message__c> doSomething(Id accountId) {

        Account acc = [
            SELECT Id, Phone
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];


      List<Message__c> ttt = new List<Message__c>();
       ttt =[SELECT Id,
                   FromPhoneNumber__c,
                   ToPhoneNumber__c,
                   Direction__c,
                   Message__c,
                   CreatedDate
            FROM Message__c
            WHERE ToPhoneNumber__c = :acc.Phone
            ORDER BY CreatedDate ASC
        ];
        System.debug('test@123333>>>>>>>>>>>>>>'+ttt);

        return [
            SELECT Id,
                   FromPhoneNumber__c,
                   ToPhoneNumber__c,
                   Direction__c,
                   Message__c,
                   CreatedDate
            FROM Message__c
            WHERE ToPhoneNumber__c = :acc.Phone
            ORDER BY CreatedDate ASC
        ];
    }
}