
class ExtraModel{
  String uri = "";
  String extension = "";
  String count="";
  String id="";
  ExtraModel.fromJson(Map<String, dynamic> parsedJson){
    uri =parsedJson['file']['uri']??  "";
    count=parsedJson["count"] ??  "0";
  }
  ExtraModel.fromJson2(Map<String, dynamic> parsedJson){
    uri =parsedJson['file']['uri']??  "";
    count=parsedJson["count"] ??  "0";
    id=parsedJson["id"]==null ? "0": parsedJson["id"].toString();
  }
}