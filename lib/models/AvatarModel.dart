
class AvatarModel{
  String uri = "";
  String extension = "";
  String name="";
  String id="";
  AvatarModel.fromJson(Map<String, dynamic> parsedJson){
    uri =parsedJson["uri"] ??  "";

  }
  AvatarModel.fromJson2(Map<String, dynamic> parsedJson){
    uri =parsedJson["uri"] ??  "";
      id=parsedJson["id"]==null ? "0": parsedJson["id"].toString();
  }
}