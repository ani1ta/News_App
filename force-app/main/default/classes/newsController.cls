public with sharing class newsController {
    @AuraEnabled
    public static Map<String, Object> retriveNews(){
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndPoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=001de0bbee604779b58465a5f02dbfa5');
        httpRequest.setMethod('GET');

        Map<String, Object> newsJsonData = new Map<String, Object>();
        String strResponse = null;

        try {
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            if(httpResponse.getStatusCode() == 200){
                strResponse = httpResponse.getBody();
            }else{
                throw new CalloutException(httpResponse.getBody());
            }
        }catch(Exception ex) {
            throw ex;
        }

        if(!String.isBlank(strResponse)){
            newsJsonData = (Map<String, Object>)JSOn.deserializeUntyped(strResponse);
        }
        if(!newsJsonData.isEmpty()){
            return newsJsonData;
        }else{
            return null;
        }
    }
}