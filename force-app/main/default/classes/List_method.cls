@isTest
public class List_method {
    public static testmethod void  main()
    {
        List <Integer> age=new List<Integer>{5,2,3,7,8,9};
        age.add(10);
        age.add(20);
        age.add(30);
       List<Integer>value=age.clone();
        System.debug(age);
        System.debug(value);
    }

}