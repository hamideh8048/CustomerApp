
class ProviderModel{
  String first_name = "";
  String last_name = "";
  String profile="";
  int id=0;
  ProviderModel.fromJson(Map<String, dynamic> parsedJson){
    first_name =parsedJson['first_name']??  "";
    last_name=parsedJson["last_name"] ??  "";
    id=parsedJson["id"] ??  0;
    profile=parsedJson["profile"] ??  "";
  }
  ProviderModel.fromString(String firstname,String lastname,int id1,String profile1){
    first_name =firstname;
    last_name=lastname;
    id=id1;
    profile=profile1;
  }
}