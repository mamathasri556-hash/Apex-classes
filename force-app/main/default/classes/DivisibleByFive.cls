public class DivisibleByFive {
    
    public static list<Integer>printNumbers() {
        List<integer> numbers = new List<Integer>();
        
        for(Integer i = 1; i <= 100; i++) {
            
            if(Math.mod(i, 5) == 0) {
                numbers.add(i); 
            }
            
        } 
        return numbers;
    } 
    
}