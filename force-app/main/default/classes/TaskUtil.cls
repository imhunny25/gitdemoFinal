public class TaskUtil {
    public static String getPrirority( String leadState)
    {
        if(String.isBlank(leadState)|| leadState.length()>2)
        {
            return null;
        }
        String taskPrirority;
        if(leadState=='CA')
        {
            taskPrirority='High';
        }else{
            taskPrirority='Normal';
        }
        
        return taskprirority;
    }

}