trigger TRG_Account on Account (before insert) {
    //for every new account
    for(Account a : Trigger.New)
    {
        //append 'Mr.' with every account name 
        a.Name = 'Mr.' + a.Name;
    }
}