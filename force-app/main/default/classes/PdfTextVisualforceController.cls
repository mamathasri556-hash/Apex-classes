global with sharing class PdfTextVisualforceController {

    @RemoteAction
    global static String getPdfBase64(String contentVersionId) {
        if (String.isBlank(contentVersionId)) {
            throw new VisualforceException(
                'ContentVersion ID is missing.'
            );
        }

        Id versionId;

        try {
            versionId = Id.valueOf(contentVersionId);
        } catch (Exception e) {
            throw new VisualforceException(
                'Invalid ContentVersion ID.'
            );
        }

        if (versionId.getSObjectType() != ContentVersion.SObjectType) {
            throw new VisualforceException(
                'Expected a ContentVersion ID.'
            );
        }

        List<ContentVersion> files = [
            SELECT Id, VersionData
            FROM ContentVersion
            WHERE Id = :versionId
            LIMIT 1
        ];

        if (files.isEmpty()) {
            throw new VisualforceException(
                'Uploaded PDF was not found.'
            );
        }

        return EncodingUtil.base64Encode(files[0].VersionData);
    }

    @RemoteAction
    global static String saveExtractedText(
        String opportunityId,
        String extractedText
    ) {
        if (String.isBlank(opportunityId)) {
            throw new VisualforceException(
                'Opportunity ID is missing.'
            );
        }

        Id oppId;

        try {
            oppId = Id.valueOf(opportunityId);
        } catch (Exception e) {
            throw new VisualforceException(
                'Invalid Opportunity ID.'
            );
        }

        if (oppId.getSObjectType() != Opportunity.SObjectType) {
            throw new VisualforceException(
                'Expected an Opportunity ID.'
            );
        }

        if (
            extractedText == null ||
            extractedText.trim().length() == 0
        ) {
            throw new VisualforceException(
                'No text was extracted from the PDF.'
            );
        }

        if (extractedText.length() > 32000) {
            extractedText = extractedText.substring(0, 32000);
        }

        update new Opportunity(
            Id = oppId,
            textExtract__c = extractedText
        );

        return 'SUCCESS';
    }
}