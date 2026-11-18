/**
 * @description Generates a random 6-digit OTP
 * using a do-while loop.
 */
public class OTPGenerator { 
    public static Integer generateOTP(){
        /**
         * @description Generates a random 6-digit OTP
         * @Apex calss - OtPGenerator
         * return the check string leangth equal to 6 then it wil correct 
         */
        Integer otp;
        do{
            otp= (Integer)(Math.random()*1000000);
        } while(String.valueOf(otp).length() !=6);
        return otp;
    } 
}