@isTest
public class ListLearn {
   public static testmethod void main(){
        List<Integer> obj = new List<Integer>();
        obj.add(67); // 0
        obj.add(456); // 1
        obj.add(34); // 2
        obj.add(9852); // 3
        obj.add(456); // 4
        obj.add(525); // 5
        system.debug(obj);
        
        obj.sort();
        System.debug(obj);
        List<Integer> age=obj.clone();
    System.debug(age);
        
    } 
}