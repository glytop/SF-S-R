public class futureApex {
	@future(callout=true)
    public static void futureCallout(List<Id> accId){
        if(accId.size() > 0){
            for(Account acc : [SELECT Id, Name, Phone FROM Account WHERE Id IN: accId]){
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint('https://nanoplc-dev-ed.develop.lightning.force.com/services/apexrest/DataAvailable');
                HttpResponse res = http.send(req);
                System.debug('Status code is' + res.getStatusCode());
                if (res.getStatusCode() == 200)
                {
                    System.debug('Success');
                }
            }
        }
    }
}