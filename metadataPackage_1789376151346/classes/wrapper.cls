Public class wrapper{
   public String AccountName;
   public String OpportunityName;
   public Decimal Amount; 
    public wrapper(String AccountName, String OpportunityName,Decimal Amount){
        this.AccountName=AccountName;
        this.OpportunityName=OpportunityName;
        this.Amount=Amount;
    } 
    public static List<Wrapper>getData(){
        List<Wrapper>Wrapperlist=new List<Wrapper>();
        List<Opportunity> opplist =[
            SELECT Name, Amount,Account.Name
            FROM Opportunity
            WHERE AccountId !=null
        ];
        for(Opportunity opp : oppList){
            Wrapper wrap = new Wrapper(
                opp.Account.Name,
                opp.Name,
                opp.Amount);
            wrapperList.add(wrap);
        }
        return wrapperList;
        
    }
}