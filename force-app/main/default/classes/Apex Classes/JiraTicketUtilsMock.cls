@isTest 
global class JiraTicketUtilsMock implements HttpCalloutMock {
    
        global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"self":"https://farhan123.atlassian.net/rest/api/3/user?accountId=712020:ab945a13-4886-4e14-8bf0-4a523ab84336","accountId":"712020:ab945a13-4886-4e14-8bf0-4a523ab84336","accountType":"atlassian","emailAddress":"dane.orge@gmail.com","avatarUrls":{"48x48":"https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/712020:ab945a13-4886-4e14-8bf0-4a523ab84336/ccac2110-e7f7-47cd-9583-0dce2572835b/48","24x24":"https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/712020:ab945a13-4886-4e14-8bf0-4a523ab84336/ccac2110-e7f7-47cd-9583-0dce2572835b/24","16x16":"https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/712020:ab945a13-4886-4e14-8bf0-4a523ab84336/ccac2110-e7f7-47cd-9583-0dce2572835b/16","32x32":"https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/712020:ab945a13-4886-4e14-8bf0-4a523ab84336/ccac2110-e7f7-47cd-9583-0dce2572835b/32"},"displayName":"Daniyal 007","active":true,"timeZone":"Asia/Karachi","locale":"en_US","groups":{"size":6,"items":[]},"applicationRoles":{"size":1,"items":[]},"expand":"groups,applicationRoles"}');
        response.setStatusCode(200);
        return response; 
    }

}