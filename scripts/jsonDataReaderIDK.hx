import haxe.Json;

typedef JsonData =
{
    minbuck:String,
    secbuck:String,
    minerect:String,
    secerect:String
}

public var kms:JsonData;

function onCreate(){
    createGlobalCallback('getJsonContent', function(pathh, namer) {
        kms = tjson.TJSON.parse(Paths.getTextFromFile(pathh));
        kms.namer;
    });
}