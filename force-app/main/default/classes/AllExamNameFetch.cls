public class AllExamNameFetch {
    @AuraEnabled
    public static List<Exam__C> fetchExtamName(){
        return[SELECT ID, Name FROM Exam__c];
    }

    @AuraEnabled
    public static List<Questions__c> fetchQuestion(String examId){
       return[SELECT Id, Name, Question__c, Correct_Answer__c, (SELECT Id, Name, Answer__c FROM Answers__r)
        FROM Questions__c Where Exam_type__c =: examId];
    }

    /*@AuraEnabled
    public static List<Answer__c> fetchAnswer(){
       return[SELECT Id, Name, Question__r.Question__c FROM Answer__c ];
    }*/
}