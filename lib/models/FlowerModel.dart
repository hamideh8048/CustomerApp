
class FlowerModel{
  String id = "";
  String name = "";
  String serialNumber = "";
  String serial_number = "";
  String water_level = "";
  String last_watering_time = "";
  String change_water_time = "";
  String warranty_activation_time = "";
  String warranty_status = "";
  String light_status = "";
  String light_hours = "";
  String pump_status = "";
  String main_user = "";
  List<String> other_users=[];
  List<String> plants=[];
  String pump_interval_minutes = "";
  String last_fertilization_time="";
  FlowerModel.fromJson(Map<String, dynamic> parsedJson){
    id =parsedJson["id"] ??  "";
    name =parsedJson["name"] ??  "";
    serial_number =parsedJson["serial_number"] ??  "";
    water_level =parsedJson["water_level"] ??  "";
    water_level =parsedJson["water_level"] ??  "";
    last_watering_time =parsedJson["last_watering_time"] ??  "";
    change_water_time =parsedJson["change_water_time"] ??  "";
  }

}