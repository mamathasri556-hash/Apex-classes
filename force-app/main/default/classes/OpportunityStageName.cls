public class OpportunityStageName { 
	public class OpportunityData{
		@AuraEnabled 
		public String stageName;
		@AuraEnabled 
		public Id recordTypeId;
	}

	@AuraEnabled(cacheable=true)
	public static OpportunityData doSomething(Id recordId) {
		List<Opportunity> result = [ 
			SELECT Id, StageName,RecordTypeId FROM Opportunity WHERE Id = :recordId 
			LIMIT 1
		];
		if(result.isEmpty()){
			return null;
		} 

	OpportunityData data = new OpportunityData();
	data.stageName = result[0].StageName;
	data.recordTypeId = result[0].RecordTypeId;  
	return data;
	}

}