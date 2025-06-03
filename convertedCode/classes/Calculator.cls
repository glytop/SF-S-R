public class Calculator{
    public Integer sum1;
    public Integer sum2;
    @TestVisible
    Integer result;
    public List<String> animals = new List<String>{ 'Parrot', 'Cat', 'Dog' };
    public void AddSum(){
        this.result = this.sum1 + this.sum2;
        System.debug(this.result);
    }

}