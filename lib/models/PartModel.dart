
class PartModel{
  String title = "";
  String id="";
  String price="0";
  PartModel.fromJson(Map<String, dynamic> parsedJson){
    title =parsedJson['title']??  "";
    price =parsedJson['price']??  "0";
    id=parsedJson["id"]==null ? "0": parsedJson["id"].toString();
  }
  PartModel.fromStringStatus(String title1,String description1,int id1,String price1){
    title=title1;
    id=id1.toString();
price=price1;
  }
}