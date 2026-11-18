@isTest
public class VehicleTest {
    @isTest
    public static void testCar(){
        Vehicle obj = new Car();
        obj.startEngine();
        obj.displayInfo();
        System.assertNotEquals(null,obj);
    }

}