public class CasetriggerHandler {
    public static void caseTest(List<Case>css){
        for(Case cs : css){
            if(cs.Priority == 'High'){
                Messaging.SingleEmailMessage mail =
                    new Messaging.SingleEmailMessage();
                
                mail.setToAddresses(
                    new List<String>{'mamatha556@gmail.com'}
                );
                
                mail.setSubject('high');
                
                mail.setPlainTextBody(
                    'A new High Priority Case has been created.'
                );
                
                Messaging.sendEmail(
                    new Messaging.SingleEmailMessage[]{mail}
                );
            }
        }
    }
    
}