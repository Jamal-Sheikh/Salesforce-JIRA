@isTest
global class JiraProjectSyncControllerMock implements HttpCalloutMock {
   
    	global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[ { "self": "https://your-domain.atlassian.net/rest/api/3/project/EX", "id": "10000", "key": "EX", "name": "Example", "avatarUrls": { "48x48": "https://your-domain.atlassian.net/secure/projectavatar?size=large&pid=10000", "24x24": "https://your-domain.atlassian.net/secure/projectavatar?size=small&pid=10000", "16x16": "https://your-domain.atlassian.net/secure/projectavatar?size=xsmall&pid=10000", "32x32": "https://your-domain.atlassian.net/secure/projectavatar?size=medium&pid=10000" }, "projectCategory": { "self": "https://your-domain.atlassian.net/rest/api/3/projectCategory/10000", "id": "10000", "name": "FIRST", "description": "First Project Category" }, "simplified": false, "style": "classic", "insight": { "totalIssueCount": 100, "lastIssueUpdateTime": "2023-12-29T02:44:19.010+0000" } }, { "self": "https://your-domain.atlassian.net/rest/api/3/project/ABC", "id": "10001", "key": "ABC", "name": "Alphabetical", "avatarUrls": { "48x48": "https://your-domain.atlassian.net/secure/projectavatar?size=large&pid=10001", "24x24": "https://your-domain.atlassian.net/secure/projectavatar?size=small&pid=10001", "16x16": "https://your-domain.atlassian.net/secure/projectavatar?size=xsmall&pid=10001", "32x32": "https://your-domain.atlassian.net/secure/projectavatar?size=medium&pid=10001" }, "projectCategory": { "self": "https://your-domain.atlassian.net/rest/api/3/projectCategory/10000", "id": "10000", "name": "FIRST", "description": "First Project Category" }, "simplified": false, "style": "classic", "insight": { "totalIssueCount": 100, "lastIssueUpdateTime": "2023-12-29T02:44:19.010+0000" } } ]');
        response.setStatusCode(200);
        return response; 
    }

}