@isTest
private class MultiTaskCreatorTest {

  @isTest static void createAccountWithSelectedItems() {
    // Create an ccount with multi-select items createAccountWithSelectedItems
    Account myAccount = new Account();
    myAccount.Name    = 'Salesforce';
    myAccount.sillyPick__c = 'Item1;Item 2;Item 3';
    insert myAccount;
  }
}