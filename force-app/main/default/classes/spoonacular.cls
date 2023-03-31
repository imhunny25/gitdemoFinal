public class spoonacular {
    
    private static final String RECEIPE_API = 'https://api.spoonacular.com';
    private static final String API_KEY ='7d4009752f3949dca8951f8e03072e51';
    
    public static void randomRecipi()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(RECEIPE_API+'/recipes/random?apiKey='+ API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode()==200)
        {
            System.debug('RandomRecpie'+ response.getBody());
        }else{
            System.debug('RandomRecpie code >>>'+ response.getStatusCode());
        }
    }
    
    public static String getRecipi()
    {
        return null;
    }
    
    

}