public class AccountTaskTriggerHandler {
    public static void getDataMethod(List<Account> accs){
        for (Account acc : accs){
            if(acc.Industry == 'Healthcare'){
                acc.Rating = 'Hot';
            }
        }
    }

}