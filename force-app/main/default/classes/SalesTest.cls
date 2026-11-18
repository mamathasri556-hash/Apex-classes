@isTest
private class SalesTest {

    @isTest
    static void testSalesBatch() {
        Date todayDate = Date.today();
        Date monthStart = todayDate.toStartOfMonth();

        List<String> monthNames = new List<String>{ 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August',  'September', 'October', 'November', 'December' };
        String currentMonthName = monthNames[monthStart.month() - 1];
        Integer currentYear = monthStart.year();
        Account acc = new Account(
            Name = 'Test Account'
        );
        insert acc;

        Product2 product = new Product2(
            Name = 'Test Product',
            IsActive = true
        );
        insert product;

        Sales_Representative__c rep = new Sales_Representative__c(
            Name = 'Test Representative',
            Status__c = 'Active',
            Email__c = 'test@example.com',
            ActiveDate__c = todayDate.addMonths(-2),
            InActive__c = null,
            User__c = UserInfo.getUserId()
        );
        insert rep;

        Comission_Tiers__c tier = new Comission_Tiers__c(
            SalesRepresentative__c = rep.Id,
            Commission_Percentage__c = 10,
            Experience_Years__c = 1,
            Amount__c = 10000,
            High_Commission__c = 25,
            Low_Commission__c = 10
        );
        insert tier;

        Asset asset = new Asset(
            Name = 'Test Asset',
            AccountId = acc.Id,
            Product2Id = product.Id,
            Price = 10000,
            Status = 'Purchased',
            PurchaseDate = todayDate,
            Sales_Representative__c = rep.Id
        );
        insert asset;

        Monthly_Commission__c monthly = new Monthly_Commission__c(
            Sales_Representative__c = rep.Id,
            Month__c = currentMonthName,
            year__c = currentYear,
            Number_of_Customer__c = 0,
            TotalAmount__c = 0,
            Commission_Amount__c = 0,
            Bonus__c = 0
        );
        insert monthly;

        Yearly_Comission_object__c yearly =
            new Yearly_Comission_object__c(
                Sales_Representative__c = rep.Id,
                Year__c = String.valueOf(currentYear),
                Number_of_Customer__c = 0,
                Annual_Sales_Amount__c = 0,
                Annual_Commission_Amount__c = 0
            );
        insert yearly;

        Test.startTest();

        Database.executeBatch(new Sales(), 200);

        Test.stopTest();

        Monthly_Commission__c updatedMonthly = [
            SELECT Month__c, year__c,
                   Number_of_Customer__c,
                   TotalAmount__c,
                   Commission_Amount__c,
                   Bonus__c
            FROM Monthly_Commission__c
            WHERE Id = :monthly.Id
        ]; 
        System.assertEquals(0, Limits.getEmailInvocations(), 'Email should be sent for the test Sales Representative');
        System.assertEquals(currentMonthName, updatedMonthly.Month__c);
        System.assertEquals(currentYear,updatedMonthly.year__c);
        System.assertEquals(Decimal.valueOf('10000'), updatedMonthly.TotalAmount__c );
        System.assertEquals(Decimal.valueOf('1000'),updatedMonthly.Commission_Amount__c);
        System.assertEquals(Decimal.valueOf('1'),updatedMonthly.Number_of_Customer__c );
        System.assert(updatedMonthly.Bonus__c > 0,'Bonus should be calculated');

        Yearly_Comission_object__c updatedYearly = [
            SELECT Year__c,
                   Number_of_Customer__c,
                   Annual_Sales_Amount__c,
                   Annual_Commission_Amount__c
            FROM Yearly_Comission_object__c
            WHERE Id = :yearly.Id
        ];

        System.assertEquals(String.valueOf(currentYear),updatedYearly.Year__c);
        System.assertEquals(Decimal.valueOf('10000'), updatedYearly.Annual_Sales_Amount__c );
        System.assertEquals( Decimal.valueOf('1000'), updatedYearly.Annual_Commission_Amount__c );
        System.assertEquals(Decimal.valueOf('1'),updatedYearly.Number_of_Customer__c );
    }
}