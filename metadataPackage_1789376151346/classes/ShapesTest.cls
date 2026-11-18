@isTest
public class ShapesTest {

    @isTest
    static void testCircle() {

        Shapes obj = new Circle();

        Integer result = obj.calculatorArea();

        System.assertEquals(45, result);
    }

    @isTest
    static void testRectangle() {

        Shapes obj = new Rectangle();

        Integer result = obj.calculatorArea();

        System.assertEquals(9, result);
    }
}