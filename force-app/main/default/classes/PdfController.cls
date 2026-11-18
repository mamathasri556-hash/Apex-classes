public with sharing class PdfController {

    @RemoteAction
    public static String ping() {
        return 'CONTROLLER_OK';
    }

    
    @AuraEnabled
    public static String uploadPdf(
        Id opportunityId,
        String fileName,
        String base64Data
    ) {
        if (
            opportunityId == null ||
            opportunityId.getSObjectType() != Opportunity.SObjectType
        ) {
            throw new AuraHandledException(
                'Please open a valid Opportunity record.'
            );
        }

        if (
            String.isBlank(fileName) ||
            String.isBlank(base64Data)
        ) {
            throw new AuraHandledException(
                'PDF file name or file data is missing.'
            );
        }

        if (!fileName.toLowerCase().endsWith('.pdf')) {
            fileName += '.pdf';
        }

        if (base64Data.length() > 2000000) {
            throw new AuraHandledException(
                'PDF is too large. Please use a smaller PDF.'
            );
        }

        try {
            String title = fileName.substring(
                0,
                fileName.length() - 4
            );

            ContentVersion cv = new ContentVersion(
                Title = title,
                PathOnClient = fileName,
                VersionData = EncodingUtil.base64Decode(base64Data),
                FirstPublishLocationId = opportunityId
            );

            insert cv;

            return cv.Id;

        } catch (Exception e) {
            throw new AuraHandledException(
                'PDF upload failed. Check file storage and permissions.'
            );
        }
    }

   
    @RemoteAction
    public static String getPdfBase64(String contentVersionId) {
        if (String.isBlank(contentVersionId)) {
            throw new VisualforceException(
                'PDF ContentVersion ID is missing.'
            );
        }

        Id versionId;

        try {
            versionId = Id.valueOf(contentVersionId);
        } catch (Exception e) {
            throw new VisualforceException(
                'The PDF ContentVersion ID is invalid.'
            );
        }

        if (
            versionId.getSObjectType() != ContentVersion.SObjectType
        ) {
            throw new VisualforceException(
                'A valid ContentVersion ID is required.'
            );
        }

        List<ContentVersion> versions = [
            SELECT Id, VersionData
            FROM ContentVersion
            WHERE Id = :versionId
            LIMIT 1
        ];

        if (versions.isEmpty()) {
            throw new VisualforceException(
                'The uploaded PDF could not be found.'
            );
        }

        return EncodingUtil.base64Encode(
            versions[0].VersionData
        );
    }

    
    @AuraEnabled
    public static void saveExtractedText(
        Id opportunityId,
        String extractedText
    ) {
        if (
            opportunityId == null ||
            opportunityId.getSObjectType() != Opportunity.SObjectType
        ) {
            throw new AuraHandledException(
                'A valid Opportunity ID is required.'
            );
        }

        if (String.isBlank(extractedText)) {
            throw new AuraHandledException(
                'Extracted text is empty.'
            );
        }

        if (extractedText.length() > 120000) {
            throw new AuraHandledException(
                'Combined extracted text is too long to save.'
            );
        }

        try {
            Opportunity opp = [
                SELECT Id
                FROM Opportunity
                WHERE Id = :opportunityId
                LIMIT 1
            ];

            opp.textExtract__c = extractedText;
            update opp;

        } catch (Exception e) {
            throw new AuraHandledException(
                'Failed to save extracted text to Opportunity.'
            );
        }
    }
}