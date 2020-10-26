@isTest
private class UpdateContatPhoneTest {

  @isTest static void updatePhoneOnAccount() {
    String country = 'US';

    Account acc        = new Account();
    acc.Name           = 'Winterfell Hotels';
    acc.BillingCountry = country;
    insert acc;

    // Crate two contacts
    List<Contact> contacts         = new List<Contact>();
    Contact conSameCountry         = new Contact();
    conSameCountry.FirstName       = 'Sensa';
    conSameCountry.LastName        = 'Startk';
    conSameCountry.AccountId       = acc.Id;
    conSameCountry.MailingCountry  = country;
    contacts.add(conSameCountry);

    Country conDiffCountry          = new Contact();
    conDiffCountry.FirstName        = 'Arya';
    conDiffCountry.LastName         = 'Stark';
    conDiffCountry.AccountId        = acc.Id;
    conDiffCountry.MailingCountry   = country + 'S';
    contacts.add(conDiffCountry);
    insert contacts;

    // Update the account phone number
    String phoneNumber = '5551234456';
    acc.Phone          = phoneNumber;
    update acc;

    contacts = [SELECT OtherPhone
                  FROM Contact
                 WHERE AccountID = :acc.Id
              ORDER BY FirstName DESC];
    
    System.assertEquals(phoneNumber, contacts.get(0).OtherPhone );
    System.assertEquals(null, contacts.get(1).OtherPhone);
  }
}