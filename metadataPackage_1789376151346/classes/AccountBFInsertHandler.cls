public class AccountBFInsertHandler {
    public static void Ratingmethod(List<Account> accounts){
        for(Account acc : accounts){
            if(acc.Rating == ' '){
                acc.Rating = 'Warm';
            }
        }
    }

}