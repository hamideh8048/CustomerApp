
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/BussinessModel.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/screens/bplanDetail.dart';
import 'package:redJAY/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ExtraIntroduction.dart';
import 'VideoIntroduction.dart';

class bPlanIntroduction extends StatefulWidget {
  const bPlanIntroduction({Key? key}) : super(key: key);

  @override
  State<bPlanIntroduction> createState() => bPlanIntroductionState();
}

class bPlanIntroductionState extends State<bPlanIntroduction>
  with TickerProviderStateMixin
{
bool showYellowBirdlogo=false;
bool isClickBird=false;
String title="Yellowjay server";
Color bgcolor=bgYellow;
  ScrollController? scrollController;
  bool pageLoading = true;
  bool gmailLoading=false;
  String companyName="";
  TextEditingController? _emailController;
  TextEditingController? _refController;
  String companyLogo="";
bool loginLoading=false;
String? _chosenValue;
String? _chosenSourceValue;
List<DropdownMenuItem<String>> dropdownItems = [];
bool loading=false;
  bool rememberme=false;




@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.

  super.dispose();
}
List<BussinessModel> bussinessList = [];
String?  token1="";
String?  lang="";
String?  projectId="";
getValueFromPref()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  lang =prefs!.getString("lang_id");//"en";
  projectId = prefs!.getString("project_id");//"1"
  token1=prefs!.getString("token");//"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  // lang ="en";//prefs!.getString("lang_id");//"en";
  // projectId = "1";//prefs!.getString("project_id");//"1"
  // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDI5OTI3MTMsImV4cCI6MTcwNTU4NTMxMywibmJmIjoxNzAyOTkyNzEzLCJqdGkiOiJXdEhld0MySUlnTDBDcHZXIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ.nLt3G4TnyCW2-TMA4_pODSzryV5FptzHB1gycdSBkP0";
//prefs!.getString("token");//

  showBussinessProvider();
  //  getStatusProvider();
}
showBussinessProvider()
async {
//  token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  // var response3 = await (Services()).getProviderList(token1!, projectId!, lang!);
  try{
    setState(() {
      loginLoading = true;
    });
    var response2 = await (Services()).ShowBusinessProvider(token1!,lang!, projectId!);
    if (response2['statusCode'] != null && response2['statusCode'] == 200) {
      response2['data'].forEach((element) {
        bussinessList.add(BussinessModel.fromJson2(element));
      });
      setState(() {
        loginLoading = false;
      });
    }
  } catch (error) {
    print(error);
    setState(() {
      loginLoading = false;
    });
  }
  // providerList.add(ProviderModel.fromString("alireza", "haghighi", 1, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));
  // providerList.add(ProviderModel.fromString("mina", "mansuri", 2, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));
  // providerList.add(ProviderModel.fromString("shayan", "tahmaseb", 3, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));
  // providerList.add(ProviderModel.fromString("babak", "jahani", 4, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));

}

@override
  initState()  {
    super.initState();
getValueFromPref();
  if(mounted){

    }
  }
int listIndex=0;
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor:  bglightRed, //Colors.white,//backgroundColor,
        body:Form(
        key: _formKey,child:

        Stack(
            alignment: Alignment.topCenter,
            children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                Image.asset("assets/images/bglang.png", fit: BoxFit.cover),
              ),

            Padding(padding: EdgeInsets.only(
              right:MediaQuery.of(context).size.width*0.21,
              top:MediaQuery.of(context).size.width*0.3,),
    child:
    Container(
    height: 65.sp,
    width: MediaQuery.of(context).size.width*0.8,
    decoration: BoxDecoration(
    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
    color: Colors.white24,
    borderRadius: BorderRadius.circular(10)),
    child:

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              ]))),
             Padding(padding: EdgeInsets.only(
               right:MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.width*0.54,),
                child:
                Container(
                    height: MediaQuery.of(context).size.height*0.75,
                    width: MediaQuery.of(context).size.width*0.89,
                    // padding: const EdgeInsets.only(left: 0.0),
                    decoration: BoxDecoration(

                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color:greyColor3,
                       // border: Border.all(color: Colors.white) ,
                        borderRadius: BorderRadius.only(topRight:  Radius.circular(30))),
                    child:

                    loginLoading?
                    Center(child:   Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        color: bgbuttonRed,
                        strokeWidth: 3,
                      ),
                    )) :
                    Padding(padding: EdgeInsets.only(left:10,right: 10),child:

                    GridView.count(

                            shrinkWrap: true,
                            crossAxisCount: 2,
                            //physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                        children: List.generate(bussinessList.length, (index) {
                          return
                            Container(
                             // width:  20.sp,//MediaQuery.of(context).size.width*0.3,
                              height: 180.sp,
                              decoration: BoxDecoration(
                              border: Border.all(color: frameColor),
                              borderRadius: BorderRadius.circular(15.sp),
                              color:greyLangColor //.withOpacity(0.1)
                          ),
                          child:
                            Column(children: [
                              SizedBox(height: 10,),
                              SizedBox(width: 80.sp,child:
                              Text(bussinessList[index].title,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color:   greyColor3 ,),maxLines: 1,)),
                              SizedBox(height: 10,),
                              SizedBox(width: 80.sp,child:
                              Text(bussinessList[index].description,maxLines: 1,style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color:   greyColor3 ,))),

                              SizedBox(height: 20,),
                              Text("Tap to see more detailssss",style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,color:   greyColor3 ,)),

                              SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  bPlanDetail(bussinessModel: BussinessModel.fromString(bussinessList[index].title,bussinessList[index].description,int.parse(bussinessList[index].id),[],bussinessList[index].price))),
                                    );
                                  },child:
                              Container(
                                width: 80,
                                height: 35.sp,
                                decoration: BoxDecoration(
                                    border: Border.all(color: bgbuttonRed),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    color: bgbuttonRed//.withOpacity(0.1)
                                ),
                                child:Center(child: Text('Submit',
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15 ,
                                    color:Colors.white  ,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ))
                            ],
                            ));

                        }
                        )
                    )

                ))),

              Positioned(
                top:MediaQuery.of(context).size.width*0.28,
                  left: 30,
                  child:
                  GestureDetector(
                      onTap: () async {

                      },
                      child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
                          border: Border.all(color: blackColor55) ,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 32,
                        width:32,
                        child:
                        Image.asset("assets/images/app.png", fit: BoxFit.cover),
                      ))))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 140.sp,
                  child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
                          border: Border.all(color: blackColor55) ,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 32,
                        width:32,
                        child:
                        Image.asset("assets/images/bplan.png", fit: BoxFit.cover),
                      )))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 245.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>  ExtraIntroduction(providerModel: widget.providerModel,backgroundColor: widget.backgroundColor,buttonColorColor: widget.buttonColorColor,bgtextColor: widget.buttonColorColor,)),
                        // );
                      },child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: blackColor55) ,
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 32,
                        width:32,
                        child:
                        Image.asset("assets/images/extra.png", fit: BoxFit.cover),
                      ))))
              )
            ]))
    );



  }

}
