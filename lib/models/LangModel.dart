
class LangModel{
  String title = "";
  String label = "";
  String detail = "";
  String id="";
  LangModel.fromJson(Map<String, dynamic> parsedJson){
    title =parsedJson["title"] ??  "";
    label =parsedJson["label"] ??  "";
    id =parsedJson["id"] .toString()??  "";
  }
  LangModel.fromJson2(Map<String, dynamic> parsedJson){
    title =parsedJson["title"] ??  "";
    label =parsedJson["label"] ??  "";
    detail =parsedJson["details"] ??  "";
    id =parsedJson["id"] .toString()??  "";
  }
}