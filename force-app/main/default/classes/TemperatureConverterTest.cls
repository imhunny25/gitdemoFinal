@isTest
private class TemperatureConverterTest {
    @isTest  static void testWarmTemp(){ 
	Decimal celsius=temperatureConverter.FahrenheitToCelsius(70);
     System.assertEquals(21.11,celsius);
       // System.debug('');
}
	 @isTest static void freezingPoint( )
    {
        Decimal celsius=temperatureConverter.FahrenheitToCelsius(32);
        System.assertEquals(0, celsius);
        System.debug(celsius);
    }
    
    @isTest static void bolingPoint()
    {
        Decimal celsius=temperatureConverter.FahrenheitToCelsius(0);
        System.assertEquals(0,celsius,' exption occur');
    }


}