import ballerina/http;

type Discussion readonly & record {|
    string id;
    string title;
    string creator;
    string description?;
|};

isolated table<Discussion> key(title) albums = table [
    {id: "uuid1", title: "First Topic", creator: "John Coltrane", description: "lorum ipsum sas"},
    {id: "uuid2", title: "Second Topic", creator: "Gerry Mulligan", description: "second lorum ipsum sasd"}
];

service /consult on new http:Listener(9090) {

    isolated resource function get discussion() returns Discussion[] {
        lock {
        return albums.clone().toArray();
        }
    }

    isolated resource function post discussion(@http:Payload Discussion discussion) returns Discussion {
        lock {
         
        albums.add(discussion);   
        }
        return discussion;
    }

    isolated resource function get discussion/[string id] () {
        
    }

    isolated resource function put discussion/[string id] (@http:Payload Discussion discussion) {
        
    }
}