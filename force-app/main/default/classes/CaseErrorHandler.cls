public class CaseErrorHandler { 
    public static void validateCases(List<Case>cases){
        for(case cos : cases){ 
            if(cos.Priority=='High' && String.isBlank(cos.Subject)){
                cos.addError('Subject is required');
                
            }
            
        } 
    } 
}