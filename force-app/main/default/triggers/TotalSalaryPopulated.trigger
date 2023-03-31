trigger TotalSalaryPopulated on Account (before insert, before update, before delete) {
     if(Trigger.isInsert){
        if(Trigger.isBefore){
           TotalSalaryPopulatedHandler.slaryPopulateInsert(Trigger.New); 
        }
    }


}