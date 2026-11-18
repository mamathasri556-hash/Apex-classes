/**
 * @description Generates a random 6-digit OTP
 * using a do-while loop.
 */
@isTest
public class OTPGeneratortest {
    @isTest
    /**
     * @description Generates a random 6-digit OTP
     * @Apex calss - OtPGenerator
     * return the check string leangth equal to 6 then it wil correct 
     */
    public static void testGenearatingOTP(){ 
        Integer result=OTPGenerator.generateOTP();
        System.assert(String.valueOf(result).length()==6,'OTP Should contain Excatly 6 digits');
        
    }
    
}