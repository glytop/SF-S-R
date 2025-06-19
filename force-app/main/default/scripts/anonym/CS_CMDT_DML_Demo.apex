// Custom settings

CountryPhoneCodes__c countryCode = new CountryPhoneCodes__c(
    Name = 'Italia',
    Phone_Codes__c = '+90'
);

//countryCode.SetupOwnerId = UserInfo.getUserId();
// countryCode.SetupOwnerId = [SELECT Id FROM Profile LIMIT 1].Id;

insert countryCode;

CountryPhoneCodes__c countryCodeToU = CountryPhoneCodes__c.getInstance('USA');
countryCodeToU.Phone_Codes__c = '+1XAXA';
update countryCodeToU;

CountryPhoneCodes__c countryCodeToD = CountryPhoneCodes__c.getInstance('USA');
delete countryCodeToD;

// CMDT

Metadata.CustomMetadata cmdtRecord = new Metadata.CustomMetadata();
cmdtRecord.fullName = 'Country_Codes__mdt.GG';
cmdtRecord.label = 'United States of America';

Metadata.CustomMetadataValue phoneCodeField = new Metadata.CustomMetadataValue();
phoneCodeField.field = 'Phone_Code__c';
phoneCodeField.value = '+1 (updated)';
cmdtRecord.values.add(phoneCodeField);

Metadata.DeployContainer deployContainer = new Metadata.DeployContainer();
deployContainer.addMetadata(cmdtRecord);

Id jobId = Metadata.Operations.enqueueDeployment(deployContainer, null);

// remove CMDT
Metadata.CustomMetadata recordToDelete = new Metadata.CustomMetadata();
recordToDelete.fullName = 'Country_Codes__mdt.Iran';

Metadata.DeployContainer deleteContainer = new Metadata.DeployContainer();
deleteContainer.addMetadata(recordToDelete);

Id deleteJobId = Metadata.Operations.enqueueDeployment(deleteContainer, new Callback());

class Callback implements Metadata.DeployCallback {
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug('Record removed');
        } else {
            System.debug('Error: ' + result.errorMessage);
            for (Metadata.DeployMessage msg : result.details.componentFailures) {
                System.debug('Error in: ' + msg.fullName + ' → ' + msg.problem);
            }
        }
    }
}