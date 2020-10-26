// AccountMatcherTest.cls
@isTest
private class AccountMatcherTest {

  @isTest statuc void noAccountMatch() {
    Contact myCon    = new Contact();
    myCon.FirstName  = 'Sansa';
    myCon.LastName   = 'Stark';
    myCon.Email      = 'sstark@winterfellhotels.com';
    insert myCon;

    Contact updatedCon = 
       [SELECT AccountId
          FROM Contact
         WHERE Id = :mCon.Id];
    System.assertEquals(null, updatedCon.AccountId);
  }

  @isTest static void accountMatchFound() {
    String domain = 'winterfellhotels.com';

    Account acc = new Account();
    acc.Name    = 'Winterfell Hotels';
    acc.Website = domain + '.jp';
    insert acc;

    Contact myCon    = new Contact();
    myCon.FirstName  = 'Sansa';
    myCon.LastName   = 'Stark';
    myCon.Email      = 'sstark@' + domain;
    insert myCon;

    Contact updatedCon =
       [SELECT AccountId
          FROM Contact
         WHERE Id = :myCon.Id];
  System.assertEquals(acc.Id, updatedCon.AccountId);
  }
}