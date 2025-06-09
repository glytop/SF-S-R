@RestResource(urlMapping='/DataAvailable/*')
global class IntegrationExpose {
	@httpGet
    global static Contact getContact(){
        Contact con = [SELECT Id, Name FROM Contact WHERE Id = '003Qy00000NgfxZIAR'];  
        return con;
    }
}