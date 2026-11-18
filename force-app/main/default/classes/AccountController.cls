public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount() {
        List<String> fieldNames = new List<String>();
        for(Schema.FieldSetMember f : Schema.SObjectType.Account.FieldSets.Account_Filed_set.getFields()){
            fieldNames.add(f.getFieldPath());
        } 
        String query = 
        'SELECT Id,' + String.join(fieldNames, ',') +
        ' FROM Account';
        return Database.query(query);
    }
        @AuraEnabled(cacheable=true)
        public static List<Map<String,String>> getFieldsFromFieldSet(){
            List<Schema.FieldSetMember> fieldSetFields = Schema.SObjectType.Account.FieldSets.Account_Filed_set.getFields();
            List<Map<String,String>> fields = new List<Map<String,String>>();
            Map<String, Schema.SObjectField> allFields = Schema.SObjectType.Account.fields.getMap(); 
            for(Schema.FieldSetMember f : fieldSetFields){
                Map<String,String> fieldInfo = new map<String,String>(); 
                String apiName = f.getFieldPath(); 
                fieldInfo.put('apiName',apiName);
                fieldInfo.put('label',f.getLabel()); 
                Schema.DescribeFieldResult describeField = allFields.get(apiName).getDescribe(); 
                fieldInfo.put( 
                    'type',
                    String.valueOf(describeField.getType())
                 ); 
                 fieldInfo.put ( 
                    'required',
                    String.valueOf(!describeField.isNillable())
                  );
                  fields.add(fieldInfo); 
            }
            return fields;


        }
    }