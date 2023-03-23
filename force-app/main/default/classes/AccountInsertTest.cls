@isTest 
public with sharing class AccountInsertTest {
    public static testmethod void testinsert()
    {
        //Create new account instance and pass your name as string input 
        Account a = new Account(name = 'Demo acccount');
        //Append Mr. with the account name
        a.name = 'Mr.' + a.name;
        insert a;
    }
}