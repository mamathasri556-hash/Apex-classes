public class ListOfAccountnames {
   /* public static Void accountNames(){ 
        List<Integer> id = new List<Integer>{
            1,
            2
        };
        List<String>accountNames = new list<String>{
              'mamathapamarthi',
              'anithasheru'
        };
        System.debug(accountNames); 
        System.debug(id);
    }*/  
    /*
    public static void accountNamess(){
        List<String> accountNamess = new List<String>{
            'mamatha',
            'anitha'
        };
        Integer serialNumber = 1;
        for(String accountName: accountNamess){
            System.debug(serialNumber + ' - '+accountName);
            serialNumber++;
        }
    } 
*/
    public static void accountNamesss(){
        List<String> accountNamesss = new List<String>{
            'mamatha',
            'anitha'
        };
            for(Integer i = 0; i <accountNamesss.size(); i++){
                System.debug((i + 1) + ' - ' + accountNamesss[i]);
            }
    }
    
}