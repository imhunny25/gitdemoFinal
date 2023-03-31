public class StudentClass {
    Integer sid, sub1, sub2, sub3, tm;
    Decimal am;
    String name;
    
    public StudentClass(){
        sid=0;
        sub1=0;
        sub2=0;
        sub3=0;
        tm=0;
        am=0;
        name='noname';
    }
    
   public void setValue(Integer id, Integer m1, Integer m2, Integer m3, String Name1)
    {
        sid=id;
        sub1=m1;
        sub2=m2;
        sub3=m3;
        name=Name1;
    }
    
    public void totalMarks()
    {
        tm=sub1+sub2+sub3;
    }
    
    public void avrageMarks()
    {
        am=tm/3;
    }
    
    public void getValues()
    {
        System.debug('Name of Student'+ name);
        System.debug('Student ID of Student'+ sid);
        System.debug('Total Marks of Student'+ tm);
        System.debug('Average Marks of Student'+ am);
    }

}