// AddOppInfoToContactsTest.cls

@isTest 
private class AddOppInfoToContactsTest {

  @isTest static void createOppOnAccount() {
    // Create a user that we will manage
    User myUser          = new User();
    myUser.FirstName     = 'Sansa';
    myUser.LastName      = 'Stark';
    myUser.Email         = 'sstark@winterfellhotels.com';
    myUser.Username      = 'sstark@winterfellhotels.com'
    myUser.Alis          = 'redhead';
    myUser.ProfileId     = [SELECT Id 
                              FROM Profile 
                             WHERE Name = 'System Administrator'].Id;
    myUser.TimeZoneSidKey = 'American/Denver';
    myUser.LocaleSidKey   = 'en-US';
    myUser.EmailEncodingKey = 'UTF-8';
    myUser.LanguageLocaleKey = 'en_US';
    myUser.ManagerId         = UserInfo.getUserId();
    insert myUser;

    Account acc = new Account();
    acc.Name    = 'Winterfell Hotels';
    insert acc;

    List<Contact> contacts = new List<Contact>();
    for (Integer i=0; i<3; i++) {
      String iString      = String.valueOf(i);
      Contact myCon       = new Contact();
      myCon.LastName      = iString;
      myCon.AccountId     = acc.Id;
      myCon.Description   = iString;
      contacts.add(myCon);
    }
    insert contacts;

    Opportunity opp = new Opportunity();
    opp.Name        = 'Winterfell Hotels';
    opp.StageName   = 'Propecting';
    opp.CloseDate   = Date.today();
    opp.AccountId   = acc.Id;
    opp.OwnerId     = myUser.Id;
    insert opp;

    List<Contact> updateContacts =
       [SELECT Description
          FROM Contact
         WHERE AccountId = :acc.Id];

    opp = 
        [SELECT CreatedBy.Name,
                CloseDate
           FROM Opportunity
          WHERE Id = :opp.Id];

    for (Contact myCon : updatedContacts) {
      System.assert(myCon.Description.contains(opp.CreatedBy.Name));
      System.assert(myCon.Description.contains(String.valueOf(opp.CloseDate)));
      System.assert(myCon.Description.contains(myUser.FirstName));
      System.assert(myCon.Description.contains(myUser.LastName));
      System.assert(myCon.Description.contains(UserInfo.getName()));
    }
  }
}