public class Arithmetic_Class {

    public Integer res { get; set; }

    public Integer num2 { get; set; }

    public Integer num1 { get; set; }

    public PageReference remainder() {
            res = Math.mod(num1,num2);
            
        return null;
    }


    public PageReference multiplication() {
        res=num1*num2;
        return null;
    }


    public PageReference divison() {
        res=num1/num2;
        return null;
    }


    public PageReference subtraction() {
        res=num1-num2;
        return null;
    }


    public PageReference addtion() {
        res=num1+num2;
        return null;
    }

}