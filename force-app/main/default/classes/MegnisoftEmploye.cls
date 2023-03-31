public class MegnisoftEmploye {
    Integer empid;
    String empname;
    Integer salary;
    
    public void inputData(Integer id, String name, Integer sal)
    {
        empid=id;
        empname=name;
        salary=sal;
    }
    
    public void outputData()
    {
        System.debug(empid);
        System.debug(empname);
        System.debug(salary);
    }
    
    public void listData()
    {
        List<Integer>ob=new List<Integer>();
        ob.add(44);
        ob.add(55);
        
        System.debug(ob);
        
        List<Integer> ints = new Integer[0];
        ints.add(55);
        ints.add(5555);
        System.debug(ints);
    }

}