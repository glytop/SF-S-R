@isTest
public class CalculatorTest {
	@isTest
    static void testAddSum(){
        Calculator calc = new Calculator();
        calc.sum1 = 5;
        calc.sum2 = 6;
        
        calc.AddSum();	
        
        System.assertEquals(11, calc.result, 'Sum should be 11');
    }
}