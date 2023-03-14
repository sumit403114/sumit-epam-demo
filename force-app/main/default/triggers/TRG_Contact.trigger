trigger TRG_Contact on Contact (after insert, after delete, after Undelete) {
    Set<Id> accId = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUndelete){
        for(Contact con : Trigger.new){
            accId.add(con.AccountId);
        }
    }
    if(Trigger.isDelete){
        for(Contact con : Trigger.old){
            accId.add(con.AccountId);
        }
    }
    List<Account> accList = [Select Id, Name, Number_of_Contacts__c ,(Select Id from contacts) from Account where Id IN : accId];
    for(Account acc :accList){
        acc.Number_of_Contacts__c = acc.contacts.size();
    }

    if(Account.SObjectType.getDescribe().isAccessible() &&
        Account.SObjectType.getDescribe().isUpdateable() && 
        accList.size() > 0)
    {
        try{
            Database.update(accList, false);
        } catch (Exception e) {
            System.debug('Error: '+e.getMessage() + e.getStackTraceString());                
        }
    }    
}