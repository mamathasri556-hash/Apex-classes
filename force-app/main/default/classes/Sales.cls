public class Sales implements Database.Batchable<SObject>, Database.Stateful {

    Map<Id, Sales_Representative__c> emailRepMap = new Map<Id, Sales_Representative__c>();
    Map<Id, Decimal> emailAmountByRep = new Map<Id, Decimal>();
    Map<Id, Decimal> emailCommissionByRep = new Map<Id, Decimal>();
    Map<Id, Decimal> emailBonusByRep = new Map<Id, Decimal>();
    Map<Id, Integer> emailCountByRep = new Map<Id, Integer>();

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Name, Email__c, ActiveDate__c, InActive__c,
                   Status__c, User__c
            FROM Sales_Representative__c
            WHERE Status__c = 'Active'
        ]);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        Set<Id> repIds = new Set<Id>();
        Map<Id, Sales_Representative__c> repMap = new Map<Id, Sales_Representative__c>();

        for (SObject record : scope) {
            Sales_Representative__c rep = (Sales_Representative__c) record;
            repIds.add(rep.Id);
            repMap.put(rep.Id, rep);
            emailRepMap.put(rep.Id, rep);

            if (!emailAmountByRep.containsKey(rep.Id)) {
                emailAmountByRep.put(rep.Id, 0);
                emailCommissionByRep.put(rep.Id, 0);
                emailBonusByRep.put(rep.Id, 0);
                emailCountByRep.put(rep.Id, 0);
            }
        }

        if (repIds.isEmpty()) {
            return;
        }

        Date todayDate = Date.today();
        Date monthStart = todayDate.toStartOfMonth();
        Date nextMonthStart = monthStart.addMonths(1);
        Integer currentMonth = monthStart.month();
        Integer currentYear = monthStart.year();
        Decimal currentYearDecimal = Decimal.valueOf(String.valueOf(currentYear));
        String currentYearName = String.valueOf(currentYear);
        Date yearStart = Date.newInstance(currentYear, 1, 1);
        Date nextYearStart = yearStart.addYears(1);
        List<String> monthNames = new List<String>{ 'January', 'February', 'March', 'April',  'May', 'June', 'July', 'August',  'September', 'October', 'November', 'December'};
        String currentMonthName = monthNames[currentMonth - 1];
        Commission_Setting__mdt setting = Commission_Setting__mdt.getInstance('TotolaAmount');

        if (setting == null || setting.Amount__c == null) {
            return;
        }

        Decimal amountLimit = setting.Amount__c;
        Map<Id, Decimal> percentageByRep = new Map<Id, Decimal>();
        Map<Id, Decimal> highCommissionByRep = new Map<Id, Decimal>();
        Map<Id, Decimal> lowCommissionByRep = new Map<Id, Decimal>();

        List<Comission_Tiers__c> tiers = [
            SELECT Id, SalesRepresentative__c,
                   Commission_Percentage__c,
                   High_Commission__c, Low_Commission__c
            FROM Comission_Tiers__c
            WHERE SalesRepresentative__c IN :repIds
            ORDER BY CreatedDate ASC
        ];

        for (Comission_Tiers__c tier : tiers) {
            if (!percentageByRep.containsKey(tier.SalesRepresentative__c)) {
                percentageByRep.put(tier.SalesRepresentative__c,tier.Commission_Percentage__c == null? 0 : tier.Commission_Percentage__c );
                highCommissionByRep.put(tier.SalesRepresentative__c, tier.High_Commission__c == null? 0 : tier.High_Commission__c);
                lowCommissionByRep.put(tier.SalesRepresentative__c,tier.Low_Commission__c == null ? 0 : tier.Low_Commission__c);
            }
        }
        Map<Id, Decimal> totalAmountByRep = new Map<Id, Decimal>();
        Map<Id, Decimal> totalCommissionByRep = new Map<Id, Decimal>();
        Map<Id, Decimal> totalBonusByRep = new Map<Id, Decimal>();
        Map<Id, Integer> totalCountByRep = new Map<Id, Integer>();
        List<Asset> monthlyAssets = [
            SELECT Id, Name, Price, Status, PurchaseDate,
                   Sales_Representative__c
            FROM Asset
            WHERE Status = 'Purchased'
            AND PurchaseDate >= :monthStart
            AND PurchaseDate < :nextMonthStart
            AND PurchaseDate <= :todayDate
            AND Sales_Representative__c IN :repIds
        ];

        for (Asset a : monthlyAssets) {

            Sales_Representative__c rep = repMap.get(a.Sales_Representative__c);

            if (rep == null || a.PurchaseDate == null) {
                continue;
            }

            if (rep.ActiveDate__c != null &&
                a.PurchaseDate < rep.ActiveDate__c) {
                continue;
            }
            if (rep.InActive__c != null &&
                a.PurchaseDate >= rep.InActive__c) {
                continue;
            }
            Decimal amount = a.Price == null ? 0 : a.Price;
            Decimal percentage = percentageByRep.containsKey(rep.Id)  ? percentageByRep.get(rep.Id) : 0;
            Decimal commission = amount * percentage / 100;
            Decimal bonusPercentage;
            if (amount > amountLimit) {
                bonusPercentage = highCommissionByRep.containsKey(rep.Id)  ? highCommissionByRep.get(rep.Id) : 0;
            } else {
                bonusPercentage = lowCommissionByRep.containsKey(rep.Id)? lowCommissionByRep.get(rep.Id) : 0;
            }
            Decimal bonus = amount * bonusPercentage / 100;
            totalAmountByRep.put(rep.Id,(totalAmountByRep.containsKey(rep.Id)? totalAmountByRep.get(rep.Id) : 0) + amount);
            totalCommissionByRep.put( rep.Id,(totalCommissionByRep.containsKey(rep.Id) ? totalCommissionByRep.get(rep.Id) : 0) + commission );
            totalBonusByRep.put(rep.Id,(totalBonusByRep.containsKey(rep.Id) ? totalBonusByRep.get(rep.Id) : 0) + bonus );
            totalCountByRep.put(rep.Id, (totalCountByRep.containsKey(rep.Id)? totalCountByRep.get(rep.Id) : 0) + 1 );
            emailAmountByRep.put(rep.Id, emailAmountByRep.get(rep.Id) + amount);
            emailCommissionByRep.put(rep.Id, emailCommissionByRep.get(rep.Id) + commission);
            emailBonusByRep.put(rep.Id, emailBonusByRep.get(rep.Id) + bonus);
            emailCountByRep.put(rep.Id, emailCountByRep.get(rep.Id) + 1);
        }
        List<Monthly_Commission__c> monthlyRecords = [
            SELECT Id, Sales_Representative__c, Month__c, year__c,
                   Number_of_Customer__c, TotalAmount__c,
                   Commission_Amount__c, Bonus__c
            FROM Monthly_Commission__c
            WHERE Sales_Representative__c IN :repIds
            AND Month__c = :currentMonthName
            AND year__c = :currentYearDecimal
        ];
        Map<Id, Monthly_Commission__c> monthlyRecordByRep = new Map<Id, Monthly_Commission__c>();
        for (Monthly_Commission__c mc : monthlyRecords) {
            if (!monthlyRecordByRep.containsKey(mc.Sales_Representative__c)) {
                monthlyRecordByRep.put(mc.Sales_Representative__c, mc);
            }
        }
        List<Monthly_Commission__c> monthlyUpdates = new List<Monthly_Commission__c>();
        for (Id repId : totalAmountByRep.keySet()) {
            Monthly_Commission__c mc = monthlyRecordByRep.get(repId);
            if (mc == null) {
                continue;
            }
            mc.TotalAmount__c = totalAmountByRep.get(repId);
            mc.Commission_Amount__c = totalCommissionByRep.get(repId);
            mc.Bonus__c = totalBonusByRep.get(repId);
            mc.Number_of_Customer__c = totalCountByRep.get(repId);
            monthlyUpdates.add(mc);
        }
        if (!monthlyUpdates.isEmpty()) {
            update monthlyUpdates;
        }
        List<Asset> yearlyAssets = [
            SELECT Id, Name, Price, Status, PurchaseDate,
                   Sales_Representative__c
            FROM Asset
            WHERE Status = 'Purchased'
            AND PurchaseDate >= :yearStart
            AND PurchaseDate < :nextYearStart
            AND PurchaseDate <= :todayDate
            AND Sales_Representative__c IN :repIds
        ];
        Map<Id, Decimal> yearlyAmountByRep = new Map<Id, Decimal>();
        Map<Id, Decimal> yearlyCommissionByRep = new Map<Id, Decimal>();
        Map<Id, Integer> yearlyCountByRep = new Map<Id, Integer>();
        for (Asset a : yearlyAssets) {
            Sales_Representative__c rep = repMap.get(a.Sales_Representative__c);
            if (rep == null || a.PurchaseDate == null) {
                continue;
            }
            if (rep.ActiveDate__c != null &&
                a.PurchaseDate < rep.ActiveDate__c) {
                continue;
            }
            if (rep.InActive__c != null &&
                a.PurchaseDate >= rep.InActive__c) {
                continue;
            }
            Decimal amount = a.Price == null ? 0 : a.Price;
            Decimal percentage = percentageByRep.containsKey(rep.Id)? percentageByRep.get(rep.Id) : 0;
            Decimal commission = amount * percentage / 100;
            yearlyAmountByRep.put(rep.Id,(yearlyAmountByRep.containsKey(rep.Id)? yearlyAmountByRep.get(rep.Id) : 0) + amount);
            yearlyCommissionByRep.put(rep.Id,(yearlyCommissionByRep.containsKey(rep.Id) ? yearlyCommissionByRep.get(rep.Id) : 0) + commission );
            yearlyCountByRep.put(rep.Id,(yearlyCountByRep.containsKey(rep.Id) ? yearlyCountByRep.get(rep.Id) : 0) + 1);
        }
        List<Yearly_Comission_object__c> yearlyRecords = [
            SELECT Id, Sales_Representative__c, Year__c,
                   Number_of_Customer__c, Annual_Sales_Amount__c,
                   Annual_Commission_Amount__c
            FROM Yearly_Comission_object__c
            WHERE Sales_Representative__c IN :repIds
            AND Year__c = :currentYearName
        ];

        Map<Id, Yearly_Comission_object__c> yearlyRecordByRep = new Map<Id, Yearly_Comission_object__c>();
        for (Yearly_Comission_object__c yc : yearlyRecords) {
            if (!yearlyRecordByRep.containsKey(yc.Sales_Representative__c)) {
                yearlyRecordByRep.put(yc.Sales_Representative__c, yc);
            }
        }

        List<Yearly_Comission_object__c> yearlyUpdates =  new List<Yearly_Comission_object__c>();
        for (Id repId : yearlyAmountByRep.keySet()) {
            Yearly_Comission_object__c yc = yearlyRecordByRep.get(repId);
            if (yc == null) {
                continue;
            }
            yc.Annual_Sales_Amount__c = yearlyAmountByRep.get(repId);
            yc.Annual_Commission_Amount__c = yearlyCommissionByRep.get(repId);
            yc.Number_of_Customer__c = yearlyCountByRep.get(repId);
            yearlyUpdates.add(yc);
        }

        if (!yearlyUpdates.isEmpty()) {
            update yearlyUpdates;
        }
    }

    public void finish(Database.BatchableContext bc) {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        Date todayDate = Date.today();
        List<String> monthNames = new List<String>{'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' };
        String monthName = monthNames[todayDate.month() - 1];
        String yearName = String.valueOf(todayDate.year());
        Decimal yearValue = Decimal.valueOf(yearName);
        Set<Id> repIds = emailRepMap.keySet();
        List<String> monthlyFields = new List<String>{ 'Id', 'Sales_Representative__c', 'Month__c', 'year__c' };
        Map<String, String> relationshipFields = new Map<String, String>();
        List<Schema.FieldSetMember> fieldSetFields = Schema.SObjectType.Monthly_Commission__c .FieldSets.Email.getFields();
        Map<String, Schema.SObjectField> fieldMap =Schema.SObjectType.Monthly_Commission__c.fields.getMap();
        for (Schema.FieldSetMember field : fieldSetFields) {
            String fieldPath = field.getFieldPath();
            Schema.DescribeFieldResult describeField = fieldMap.get(fieldPath).getDescribe();

            if (describeField.getType() == Schema.DisplayType.REFERENCE) {
                String relationshipName = describeField.getRelationshipName();

                if (relationshipName != null) {
                    String relationshipPath =  relationshipName + '.Name';relationshipFields.put(fieldPath, relationshipPath);
                    if (!monthlyFields.contains(relationshipPath)) {
                        monthlyFields.add(relationshipPath);
                    }
                }

            } else if (!monthlyFields.contains(fieldPath)) {
                monthlyFields.add(fieldPath);
            }
        }

        String monthlyQuery =
            'SELECT ' + String.join(monthlyFields, ',') +
            ' FROM Monthly_Commission__c' +
            ' WHERE Sales_Representative__c IN :repIds' + ' AND Month__c = :monthName' + ' AND year__c = :yearValue';

        List<Monthly_Commission__c> monthlyRecords = Database.query(monthlyQuery);
        Map<Id, Monthly_Commission__c> monthlyRecordByRep =  new Map<Id, Monthly_Commission__c>();
        for (Monthly_Commission__c mc : monthlyRecords) {
            if (!monthlyRecordByRep.containsKey(mc.Sales_Representative__c)) {
                monthlyRecordByRep.put(mc.Sales_Representative__c, mc);
            }
        }

        for (Id repId : emailRepMap.keySet()) {

            Sales_Representative__c rep = emailRepMap.get(repId);

            if (rep.User__c == null) {
                continue;
            }

            Monthly_Commission__c monthlyRecord =  monthlyRecordByRep.get(repId);
            String dynamicRows = '';
            if (monthlyRecord != null) {
                for (Schema.FieldSetMember field : fieldSetFields) {
                    String fieldPath = field.getFieldPath();
                    String displayPath =relationshipFields.containsKey(fieldPath) ? relationshipFields.get(fieldPath): fieldPath;
                    Object value =getFieldSetValue(monthlyRecord, displayPath);
                    String fieldValue = value == null ? '' : String.valueOf(value).escapeHtml4();
                    dynamicRows +='<tr>' + '<td style="padding:10px;border:1px solid #ddd;">' +  field.getLabel().escapeHtml4() +
                        '</td>' + '<td style="padding:10px;border:1px solid #ddd;">' +
                        fieldValue +'</td>' + '</tr>';
                }
            }

            Decimal totalAmount =emailAmountByRep.containsKey(repId) ? emailAmountByRep.get(repId) : 0;
            Decimal commission =emailCommissionByRep.containsKey(repId) ? emailCommissionByRep.get(repId) : 0;
            Decimal bonus =emailBonusByRep.containsKey(repId) ? emailBonusByRep.get(repId) : 0;
            Integer assetCount = emailCountByRep.containsKey(repId) ? emailCountByRep.get(repId) : 0;
            Decimal totalEarnings = commission + bonus;

            String htmlBody =
                '<html><body style="font-family:Arial,sans-serif;color:#333;">' +'<div style="max-width:650px;margin:auto;padding:20px;">' +'<h2 style="text-align:center;color:#244f91;">' +
                'Monthly Sales Commission Summary</h2>' + '<p>Hello <b>' + rep.Name.escapeHtml4() + '</b>,</p>' +
                '<p>Your sales performance summary for <b>' +
                monthName + ' ' + yearName + '</b>:</p>' + '<table style="width:100%;border-collapse:collapse;margin-top:20px;">' +'<tr style="background-color:#28569b;color:white;">' +
                '<th style="padding:12px;text-align:left;">Details</th>' + '<th style="padding:12px;text-align:left;">Value</th>' + '</tr>' +
                dynamicRows +
                '<tr><td style="padding:10px;border:1px solid #ddd;">Assets Sold</td>' +'<td style="padding:10px;border:1px solid #ddd;">' +assetCount + '</td></tr>' +
                '<tr><td style="padding:10px;border:1px solid #ddd;">Total Sales Amount</td>' +'<td style="padding:10px;border:1px solid #ddd;">₹' + totalAmount.setScale(2) + '</td></tr>' +
                '<tr><td style="padding:10px;border:1px solid #ddd;">Commission</td>' +'<td style="padding:10px;border:1px solid #ddd;">₹' +commission.setScale(2) + '</td></tr>' +
                '<tr><td style="padding:10px;border:1px solid #ddd;">Bonus</td>' + '<td style="padding:10px;border:1px solid #ddd;">₹' + bonus.setScale(2) + '</td></tr>' +
                '<tr style="background-color:#dce9ff;font-weight:bold;">' + '<td style="padding:12px;border:1px solid #ddd;">Total Earnings</td>' + '<td style="padding:12px;border:1px solid #ddd;">₹' +totalEarnings.setScale(2) + '</td></tr>' +
                '</table>' +'<p style="margin-top:25px;">Thank you!</p>' +'<p style="color:#777;">Sales Team</p>' +
                '</div></body></html>';

            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            email.setTargetObjectId(rep.User__c);
            email.setSubject('Monthly Sales Commission Summary - ' + monthName + ' ' + yearName);
            email.setHtmlBody(htmlBody);
            email.setSaveAsActivity(false);
            emailList.add(email);
        }

        System.debug('Total emails prepared: ' + emailList.size());
        for (Integer i = 0; i < emailList.size(); i += 10) {

            List<Messaging.SingleEmailMessage> emailBatch = new List<Messaging.SingleEmailMessage>();

            for (Integer j = i;j < Math.min(i + 10, emailList.size()); j++) {
                emailBatch.add(emailList[j]);
            }

            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailBatch, false);

            for (Integer k = 0; k < results.size(); k++) {

                if (results[k].isSuccess()) {
                    System.debug('Email accepted: ' + (i + k));
                } else {
                    for (Messaging.SendEmailError err :
                         results[k].getErrors()) {

                        System.debug('Email failed: ' + err.getMessage() );
                    }
                }
            }
        }

        System.debug('Sales Batch and Monthly Emails completed.');
    }

    private static Object getFieldSetValue(SObject record,String fieldPath) {

        if (record == null || String.isBlank(fieldPath)) {
            return null;
        }

        List<String> parts = fieldPath.split('\\.');SObject currentRecord = record;
        for (Integer i = 0; i < parts.size() - 1; i++) {

            currentRecord = currentRecord.getSObject(parts[i]);

            if (currentRecord == null) {
                return null;
            }
        }

        return currentRecord.get(parts[parts.size() - 1]);
    }
}