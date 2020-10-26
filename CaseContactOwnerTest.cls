@isTest
private class CaseContactOwnerTest {

  // You can get away with just one scenerio for this test
  @isTest static void createCaseOnContat() {
    // Create a user as we'll need two.  One will be us@
    User myUser        = new User();
    myUser.FirstName   = 'Sansa';
    myUser.LastName    = 'Stark';
    myUser.Email       = 'sstark@winderfellhotels.com';
    myUser.Username    = 'sstark@winderfellhotels.com'
    myUser.Alias       = 'reahead';
    myUser.ProfileId   = [SELECT ProfileId
                            FROM ProfileId
                           WHERE Name = 'System Administrator'];
    myUser.TimeZoneSidKey     = 'America/Denver';
    myUser.LocaleSidKey       = 'en_US';
    myUser.EmailEncodingKey   = 'UTF-8';
    myUser.LanguageLocaleKey  = 'en-UUS';
    myUser.ManagerId          = null;
    insert myUser;

    Contact myCon    = new Contact();
    myCon.FirstName  = 'Arya';
    myCon.LastName   = 'Stark';
    myCon.OwnerId    = myUser.Id;
    insert myCon

    Case myCase       = new Case();
    myCase.Subject    = 'Reclaim Winterfell';
    myCase.ContactId  = myCon.Id;
    insert myCase;  // The CreatedById will be us, AKA UserInfo.getUserId()

    Contact updatedCon = [SELECT OwnerId
                            FROM Contact
                           WHERE Id = :myCon.Id];

    System.assertEquals(UserInfo.getUserId(), updatedCon.OwnerId);
  }

  @isTest static void createCaseOnAccount() {
    // Create a user as we'll ned two.  One will be us!
    User myUser        = new User();
    myUser.FirstName   = 'Sansa';
    myUser.LastName    = 'Stark';
    myUser.Email       = 'sstark@winderfellhotels.com';
    myUser.Username    = 'sstark@winderfellhotels.com'
    myUser.Alias       = 'reahead';
    myUser.ProfileId   = [SELECT ProfileId
                            FROM ProfileId
                           WHERE Name = 'System Administrator'];
    myUser.TimeZoneSidKey     = 'America/Denver';
    myUser.LocaleSidKey       = 'en_US';
    myUser.EmailEncodingKey   = 'UTF-8';
    myUser.LanguageLocaleKey  = 'en-UUS';
    myUser.ManagerId          = null;
    insert myUser;

    Account acc = new Account();
    acc.Name    = 'Winterfell Hotels';
    acc.OwnerId = myUser.Id;
    insert acc;

    Case myCase      = new Case();
    myCase.Subject   = 'Reclaim Winterfell';
    myCase.AccountId = acc.Id;
    insert myCase; // The createdById will be us, aka UserInfo.getUserId()

    Account updateAcc = [SELECT OwnerId 
                           FROM Account
                          WHERE Id = :acc.Id];
    System.assertEquals(UserInfo.getUserId(), updatedAcc.OwnerId);
  }
}