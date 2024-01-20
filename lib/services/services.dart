import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
// import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:http/http.dart' as http;

class Services {

  String baseURL = "https://petroskadeh.com/api";
  Future getAddress(String ref,String address,String email  ) async
  {
    final queryParameters =
     {
      "email" : email,
      "address":address,
      "refrr":ref
    };
    final uri=  Uri.parse(baseURL + '/api-address');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI);
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  Future getWallet(String email ) async {
    final queryParameters = {
      "email" : email,
    };
    final uri=  Uri.parse(baseURL + '/get-wallet');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI);
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  Future register(String email ,String langid,String? pass,String type,String first,String last) async {
    final queryParameters = {
      "email" : email,
      "first_name" : first,
      "last_name" : last,
      "email" : email,
      "lang_id":langid,
      "password":pass,
      "type":type,"project_id" :"1"
    };
    final uri=  Uri.parse(baseURL + '/register');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI);
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future saveProfile(String token ,String langid,String? firstname,String? lastname,String age) async {
    final queryParameters = {
     // "phone" : phone,
      "first_name":firstname,
    //  "education":education,
      "last_name":lastname,
     // "last_name":lastname,
    //  "address":address,
      "lang_id":langid,
     // "source_country":source,
    //  "target_country":target,
      "age" :age
    };
  //  "raw": "{\r\n    \"phone\" : \"09372837491\",\r\n    \"first_name\" : \"saman\",\r\n    \"last_name\": \"sss\",\r\n    \"address\" : \"sss\",\r\n    \"age\" : 22,\r\n    \"education\": \"sss\",\r\n    \"source_country\" : 3,\r\n    \"target_country\" : 4,\r\n    \"lang_id\" : 2\r\n}"
   // String token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsibm9ybWFsIiwicHJlbWl1bSIsInN1cGVyIl0sIngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6Im5vcm1hbCIsIlgtSGFzdXJhLVVzZXItSWQiOiJmNDVmNjdkZi02ZTkwLTQ4NTktYTRjYy1kZTMyZWY3MWVlNWIifSwiaWF0IjoxNjg0MDU3MzYyLCJleHAiOjE2OTAyNzgxNjJ9.V1vFzRvS1QHko6rKTWMGe7a1TXZWXo5hIhd22lviYkw';
    final uri=  Uri.parse(baseURL + '/update-profile');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.put(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  Future showProfile(String token ) async {

    final uri=  Uri.parse(baseURL + '/show-profile');

    final response = await http.get(uri,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future getCountries(String token) async {
    final uri=  Uri.parse(baseURL + '/list-countries');
    final response = await http.get(uri,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future Login(String email ,String langid,String pass) async {
    final queryParameters = {
      "email" : email,
      "lang_id":langid,
      "password":pass,
      "project_id" :"1"
    };
    final uri=  Uri.parse(baseURL + '/login');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI);
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future checkEmail(String email ,String address) async {
    final queryParameters = {
      "email" : email,
      "address":address
    };
    final uri=  Uri.parse(baseURL + '/check-email');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI);
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future getLang() async {

    final uri=  Uri.parse(baseURL + '/list-languages');
    final response = await http.get(uri);
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future getProjects() async {

    final uri=  Uri.parse(baseURL + '/list-projects');
    final response = await http.get(uri);
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future updateProject(String token,String lang,String project ) async {

    final queryParameters = {
      "project_id" : project,
      "lang_id":lang
    };
    final uri=  Uri.parse(baseURL + '/last-user-location-project');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
 Future getStatusProvider(String token,String project,String lang ) async {
   final queryParameters = {
     "project_id" : project,

     "lang_id":lang
   };
    final uri=  Uri.parse(baseURL + '/status-provider');
  final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post( newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future getProviderList(String token,String project,String lang ) async {
    final queryParameters = {
      "project_id" : project,
      "lang_id":lang
    };
    final uri=  Uri.parse(baseURL + '/list-provider');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post( newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future getStatusExtra(String token ,  String  project,String lang) async {
    final queryParameters = {
      "project_id" : project,
      "lang_id":lang
    };
    final uri=  Uri.parse(baseURL + '/status-provider');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future getStatusPresent(String token ,  String  project,String lang) async {
    final queryParameters = {
      "project_id" : project,
      "lang_id":lang
    };
    final uri=  Uri.parse(baseURL + '/status-presentation-provider');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future ShowListProvide(String token ,  String  project,String lang) async {
    final queryParameters1 = {
      "project_id" : project,
      "lang_id":lang
    };
   // String u=baseURL+'/list-provider';
    final uri=  Uri.parse(baseURL+'/list-provider');
    final newURI2 = uri.replace(queryParameters: queryParameters1);
    final response = await http.post(newURI2,headers: {
      'Content-Type': 'application/json',
     // 'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future showList2(String token,String projectId) async {
    Map data = {
      "project_id" :projectId,

      "lang_id":'en',

      // 'apikey': '12345678901234567890'
    };

    final String jsonProduct = json.encode(data);

    final uri=  Uri.parse(baseURL + '/list-providers');
    //[[[[
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );

    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future createPartBusiness(String token,String bussinessId,String lang,String projectId,String title,String price,String month) async {
    Map data = {
      "project_id" :projectId,
      "title":title,//title,
      "business_id":bussinessId,
      "price" : price,
      "lang_id":lang,
      "month":month,
      // 'apikey': '12345678901234567890'
    };

    final String jsonProduct = json.encode(data);

    final uri=  Uri.parse(baseURL + '/create-part-business');
    //[[[[
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );

    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future removePartBusiness(String token,String lang,String projectId,String bussinessId) async {
    Map data = {
      "project_id" :projectId,
      "lang_id":lang,
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse(baseURL + '/delete-part-business/'+bussinessId);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future createBusiness(String token,String lang,String projectId,String description,String title,String price,String month,String urii,String ext,String name,String alt,String size,String data,String type) async {
    Map data = {
      "project_id" :projectId,
      "title":title,
      "description":description,
      "price" : price,
      "lang_id":lang,
      "month":3,
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };

    final String jsonProduct = json.encode(data);

    final uri=  Uri.parse(baseURL + '/create-business');
    //[[[[
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );

    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future editBusiness(String token,String lang,String bussinessId,String projectId,String description,String title,String price,String month,String urii,String ext,String name,String alt,String size,String data,String type) async {
    Map data = {
      "project_id" :projectId,
      "title":title,
      "description":description,
      "price" : price,
      "lang_id":lang,
      "month":3,
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };

    final String jsonProduct = json.encode(data);

    final uri=  Uri.parse(baseURL + '/edit-business/'+bussinessId);
    //[[[[
    var response = await http.put(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );

    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future createProvider(String token,String projectId,String phone ,String age,String address,String work,String source,
      String lang , String support,String job,String social,String urii,String ext,String name,String alt,String size,String data,String type) async {
    Map data = {
      "project_id" :projectId,
      "age":age,
      "address":address,
      "phone" : phone,
      "work_experience":work,
      "source_country":source,
      "lang_id":lang,
      "support_language":
      ["korea","japanese"],

      "job_title":job,"social_id":"1",
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };

    final String jsonProduct = json.encode(data);

    final uri=  Uri.parse(baseURL + '/create-provider');
   //[[[[
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );

    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future UpdateProvider(String token,String project_id,String phone ,String age,String address,String work,String source,
      String lang , String support,String job,String social,String urii,String ext,String name,String alt,String size,String data,String type) async {
    support="korea";
    Map data = {
      "project_id" :project_id,
      "age":age,
      "address":address,
      "phone" : phone,
      "work_experience":work,
      "source_country":source,
      "lang_id":lang,
      "support_language": ["korea","japanese"],"job_title":job,"social_id":"1",
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse(baseURL + '/update-provider');
    //[[[[
    var response = await http.put(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future createProvider2(String token,String phone ,String age,String address,String work,String source,
      String lang , String support,String job,String social,String avatar ) async {
  //  avatar="{uri:$uri,$extension,type:$type,size:$size,name:$name,alt:$alt,data:$data}"
    Map data = {
    'uri':'https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png',
    'extension':'png',
    'type':'avatar',
    'size':'150192',
    'name':'image.png',
    'alt':'image.png',
    'data': ''
   // 'apikey': '12345678901234567890'
    };

    List<Map<String,String>> photo = [
      {
        "uri":"https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png","extension":"png","type":"avatar","size":"150192","name":"image.png","alt":"image.png","data": ""
      },

    ];
    final String jsonProduct = json.encode(data);
    final queryParameters = {
      "project_id" :"1",
      "age":age,
      "address":address,
      "phone" : phone,
      "work_experience":work,
      "source_country":source,
      "lang_id":lang,
      "support_language":support,"job_title":job,"social_id":social,"avatar": jsonProduct
      //
      // + json.encode(
    //       {
    //         //"uri":"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png",
    //         "extension":"png","type":"avatar","size":"150192","name":"image.png","alt":"image.png","data": ""
    //
    //       }
    //
    //   )+ "]",
     };
///////////////////////
    final uri2=  Uri.parse(baseURL + '/create-provider');
    final newURI2 = uri2.replace(queryParameters: queryParameters);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(newURI2);
    request.headers.set('Accept', 'application/json');
    request.headers.set('Content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');
   // headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // }
   // request.add(utf8.encode(json.encode(jsonMap)));
  //  request.add(utf8.encode(json.encode(queryParameters)));

    HttpClientResponse response2 = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response2.transform(utf8.decoder).join();
    print("reply"+reply);
    httpClient.close();
    return reply;

    /////////////////////
    final uri=  Uri.parse(baseURL + '/create-provider');
    final newURI = uri.replace(queryParameters: queryParameters);
    var bytes = utf8.encode(json.encode( queryParameters));
    final response =  await http.post(newURI, body: bytes, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // final response = await http.post(
    //     newURI,headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    // });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future createPresentation(String token,String projectId,String lang,String urii,String ext,String name,String alt,String size,String data,String type) async {
    Map data = {
      "project_id" :projectId,
      "lang_id":lang,
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse(baseURL + '/create-presentation-provider');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future updatePresentation(String token,String projectId,String lang,String urii,String ext,String name,String alt,String size,String data,String type,String id) async {

    Map data = {
      "project_id" :projectId,
      "lang_id":lang,
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };

    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse(baseURL + '/update-presentation-provider/'+id);
    //[[[[
    var response = await http.put(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future updatePresentation3(String token,String projectId,String lang,String urii,String ext,String name,String alt,String size,String data,String type) async {

    //  avatar="{uri:$uri,$extension,type:$type,size:$size,name:$name,alt:$alt,data:$data}"
    Map data = {
      'uri':'https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png',
      'extension':'png',
      'type':'avatar',
      'size':'150192',
      'name':'image.png',
      'alt':'image.png',
      'data': ''
      // 'apikey': '12345678901234567890'
    };


    final String jsonProduct = json.encode(data);
    final queryParameters = {
      "project_id": "1",

      "lang_id": lang,
      "avatar": jsonProduct
    };
    final uri2=  Uri.parse(baseURL + '/update-presentation-provider');
    final newURI2 = uri2.replace(queryParameters: queryParameters);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.putUrl(newURI2);
    request.headers.set('Accept', 'application/json');
    request.headers.set('Content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');
    HttpClientResponse response2 = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response2.transform(utf8.decoder).join();
    print("reply"+reply);
    httpClient.close();
    return reply;


  }
  Future updatePresentation22(String token,String projectId,String lang,String urii,String ext,String name,String alt,String size,String data,String type) async {
    Map data = {
      "project_id" :projectId,
      "lang_id":lang,
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse(baseURL + '/update-presentation-provider');

    var response = await http.put(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future createExtra(String token,String projectId,String count,String lang,String urii,String ext,String name,String alt,String size,String data,String type) async {
    Map data = {
      "project_id" :projectId,
      "lang_id":lang,
      "count":count,
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse(baseURL + '/create-extraInformation-provider');

    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future updateExtra(String token,String projectId,String count,String lang,String urii,String ext,String name,String alt,String size,String data,String type,String id) async {
    Map data = {
      "project_id" :projectId,
      "lang_id":lang,
      "count":count,
      "avatar":
      [{
        'uri': urii,
        'extension': ext,
        'type': type,
        'size': size,
        'name': name,
        'alt': alt,
        'data': ''
      }]
      // 'apikey': '12345678901234567890'
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse(baseURL + '/update-extraInformation-provider/'+id);
    var response = await http.put(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Bearer $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future ShowBusinessProvider( String token,String lang ,String projectid ) async {
    final queryParameters = {
      "lang_id":lang,
      "project_id":projectid,
    };
    final uri=  Uri.parse(baseURL + '/list-provider-business');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future ShowBussiness( String token,String lang ,String projectid,String bussiness ) async {
    final queryParameters = {
      "lang_id":lang,
      "project_id":projectid,
    };
    final uri=  Uri.parse(baseURL + '/show-business/'+bussiness);
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future ShowProvider( String token,String lang ,String projectid ) async {
    final queryParameters = {
      "lang_id":lang,
      "project_id":projectid,
    };
    final uri=  Uri.parse(baseURL + '/show-provider');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future ShowExtra( String token,String lang ,String projectId ) async {
    final queryParameters = {
      "lang_id":lang,"project_id":projectId
    };
    final uri=  Uri.parse(baseURL + '/show-extraInformation-provider');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future ShowPresentation( String token,String lang ,String projectId ) async {
    final queryParameters = {
      "lang_id":lang,"project_id":projectId
    };
    final uri=  Uri.parse(baseURL + '/show-presentation-provider');
    final newURI = uri.replace(queryParameters: queryParameters);
    final response = await http.post(newURI,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future Uploader( String token,String lang,File file  ) async {
  //  String src = "/storage/emulated/0/Download/image.png";
    try {
      final queryParameters = {
        "type" : "avatar",
      };
      final uri2 = Uri.parse(baseURL + '/uploader');
      final newURI = uri2.replace(queryParameters: queryParameters);
      var request = http.MultipartRequest('POST', newURI);
      request.headers['Content-Type']='application/json';
      request.headers['Accept']='application/json';
      request.headers['authorization']='Bearer $token';
      request.files.add(
          http.MultipartFile(
              'file',
            //  File(src).readAsBytes().asStream(),
            //  File(src).lengthSync(),
               file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path
                  .split("/")
                  .last
          )
      );
          var response = await http.Response.fromStream(await request.send());
    var responseBody = json.decode(response.body);
    return responseBody;

    }
    catch (error) {
      print(error);
    }

  }

}

