@isTest
public class MapPretics {
     public static testmethod void main(){
  List<Integer> li = new List<Integer>();
       
        li.add(1);
        li.add(5);
        li.add(3);
        li.add(1);
        li.add(2);
        li.add(4);
        li.add(6);
        li.add(4);
        li.add(8);
        li.add(7);
       
        System.debug('========================List li:'+li);
        // ========================List li:(1, 5, 3, 1, 2, 4, 6, 4, 8, 7)
       
        for(Integer val: li) {
            System.debug('---------------------Value: '+val);
     }
         
         
             Set<Integer> se = new Set<Integer>();
       
        se.add(1);
        se.add(5);
        se.add(3);
        se.add(1);
        se.add(2);
        se.add(4);
        se.add(6);
        se.add(4);
        se.add(8);
        se.add(7);
       
        System.debug('========================Set se:'+se);
        // ========================List li:(1, 5, 3, 1, 2, 4, 6, 4, 8, 7)
        //========================Set se:{1, 2, 3, 4, 5, 6, 7, 8}
       
        for(Integer val: se) {
            System.debug('---------------------Value: '+val);
        }
     }}