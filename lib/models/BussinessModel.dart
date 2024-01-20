
import 'PartModel.dart';

class BussinessModel{
  String title = "";
  String description = "";
  String id="";
  String status="";
  String price="0";
  List<PartModel> parts=[];
  BussinessModel.fromJson(Map<String, dynamic> parsedJson){
    title =parsedJson['title']??  "";
    id=parsedJson["id"]==null ? "0": parsedJson["id"].toString();
    description =parsedJson['description']??  "";
  }
  BussinessModel.fromJson2(Map<String, dynamic> parsedJson){
    title =parsedJson['title']??  "";
    id=parsedJson["id"]==null ? "0": parsedJson["id"].toString();
    description =parsedJson['description']??  "";
    status =parsedJson['status']??  "";
   // id=parsedJson["id"]==null ? "0": parsedJson["id"].toString();
  }
  BussinessModel.fromString(String title1,String description1,int id1,List<PartModel> lst,String price1){
  title=title1;
  description=description1;
  id=id1.toString();
  parts=lst;
  price=price1;
  }
  BussinessModel.fromStringStatus(String title1,String description1,int id1,String status){
    title=title1;
    description=description1;
    id=id1.toString();
    id=id1.toString();
  }
}