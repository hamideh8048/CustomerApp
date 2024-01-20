
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/services.dart';


const Color buttonColor = Color(0xff2E62F6); // سرمه ای
const Color buttonGreenColor = Color(0xff339E78); // سرمه ای
const Color accentColor = Color(0xffff6a00);
const Color redColor = Color(0xffFF213C);
const Color blackColor = Color(0xff39394E);
const Color blackColor55 = Color(0xff53596D);
const Color blackColor56 = Color(0xff5D606B);
const Color blackColor57 = Color(0xff53596D);
const Color blackColor58 = Color(0xffD9D9D9);
const Color backgroundColor = Color(0xffffffff);
const Color backgroundColor2 = Color(0xffffffff);
const Color greyColor = Color(0xff9BA5B7);
const Color greyLangColor = Color(0xff8D99ae);
const Color greyColor3 = Color(0xff2B2d42);
const Color greyColor2 = Color(0xff8d99ae);
const Color greenColor = Color(0xff58ff55);


const Color frameColor = Color(0xffEDF2F4);
const Color bgYellow = Color(0xffFFD926);
const Color bgGray = Color(0xff434343);

const Color bgGray2 = Color(0xffEDF2F4);
const Color bglightRed = Color(0xffEF233C);
const Color bgpink = Color(0xffEF23ff);
const Color bgRed = Color(0xffEDF2F4);
const Color bgbuttonRed = Color(0xffD90429);

const TextStyle buttonFormat = TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold, );

OverlaySupportEntry customNotification(bool isError,String title,double
  width,double height){
  return showSimpleNotification(

    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: width,
            height: 60,
            child: Text(title)

          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              animationDuration: 3800,
              percent: 1,
              progressColor:isError ? Colors.red : Colors.green,
              animateFromLastPercent: true,
              animation: true,
            ),
          )
        ],
      ),
    ),duration: const Duration(seconds: 10),
    elevation: 25,
    background: Colors.transparent,
  );
}


OverlaySupportEntry customNotification3(BuildContext context,bool isError,String title){
  return showSimpleNotification(
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Text(title)

          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(children: [

                 GestureDetector(
                onTap: (){
          // setState(() {
          // isSelected = !isSelected;
          // });
          },
              child:
             Text("Yes")
                 ),
              GestureDetector(
                  onTap: (){
                    // setState(() {
                    // isSelected = !isSelected;
                    // });
                  },
                  child:
                  Text("No")
              )
              ]))
            ])
          ));

}

showAlertRefDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: Text("Yes"),
    onPressed:  () {},
  );
  Widget continueButton = ElevatedButton(
    child: Text("No"),
    onPressed:  () {},
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("Do you have refrral code?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertCopyDialog(BuildContext context,String ref) {
  // set up the buttons
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(

        backgroundColor: Colors.white,
        foregroundColor: Colors.blue, // change background color of button

        textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400
        )),
    child: Text("Ok"),
    onPressed:  () {
      Navigator.of(context).pop(false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Copied to clipboard:"),
    content:
        SizedBox(
            height: 65,
            child:
   Column(
       mainAxisAlignment: MainAxisAlignment.start,

       children:[
   // Text("Copied to clipboard:"),
     Text("$ref"),
    SizedBox(height: 10,),
    Divider(
      color: Colors.black,
    )
    ])),
    actions: [
      okButton,

    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showCopyDialog(BuildContext context) {
  // set up the buttons
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(

        backgroundColor: Colors.white,
        foregroundColor: Colors.blue, // change background color of button

        textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400
        )),
    child: Text("Ok"),
    onPressed:  () {
      Navigator.of(context).pop(false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content:
    SizedBox(
        height: 70,
        child:
        Column(children:[
          Text("Copied to clipboard"),
          SizedBox(height: 10,),
          Divider(
            color: Colors.black,
          )
        ])),
    actions: [
      okButton,

    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<bool> showAlertDialog(BuildContext context, String message) async {
  // set up the buttons
  bool returnValue=false;
  Widget cancelButton = ElevatedButton(
    child: Text("Yes"),
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue, // change background color of button

        textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400
        )),
    onPressed: () {
     returnValue = true;
      Navigator.of(context).pop(false);

    },
  );
  Widget continueButton = ElevatedButton(
    child: Text("No"),
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red, //
        textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
        )),
    onPressed: () {
     returnValue = false;
      Navigator.of(context).pop(true);
    },
  ); // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    //title: Text("Do you want to continue?"),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  final result = await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return returnValue ;
}
void storeEmail(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("email", userId);
  // getUserInfo(tokenResult);
}
void storeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
  // getUserInfo(tokenResult);
}
void storeRef(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("reff", userId);
  // getUserInfo(tokenResult);
}

ShowDialogInvite(String refCode,BuildContext context)
{
  TextEditingController? _refController= TextEditingController(text: "");
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 390.0,
      width: 250.0,
      //color: bgYellow,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
SizedBox(height: 20,),
      SizedBox(
          width: 100,
          child:
      Image.asset("assets/images/bird.png", fit: BoxFit.fill),
    ),
          Padding(
              padding: EdgeInsets.only(top: 10,bottom: 15),
              child:
              Center(child:
              Text('Invite',
                style: TextStyle(fontSize:16,fontWeight: FontWeight.w700 ),)
              )
            // )

          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
            child:   Text('Your refferal code :${refCode} Invite your freind and earn money',  maxLines: 3,
              style: TextStyle(fontSize:15,fontWeight: FontWeight.w400 ),)
              // )

       ),
SizedBox(height: 20,),
      Container(
        width: 250,
        decoration: BoxDecoration(
          border: Border(

            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),child:
          TextButton(onPressed: () {

            FlutterClipboard.copy(refCode).then(( value ) =>
               showAlertCopyDialog(context, refCode));


        //    getRefer(email,add,_refController.text,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          },
           //   style:TextButton.styleFrom( backgroundColor:Colors.black),
              child: Text('Copy', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w400,  ),))
      ),
          Container(
              width: 250,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: greyColor),
                ),
              ),child:
          TextButton(onPressed: () {
            Share.share('If privacy is important to you, you should use a VPN every time you connect to the internet. A VPN app runs in the background of your device so it won’t get in the way while you use other apps and browse the internet. And you’ll have peace of mind knowing your privacy is always protected.See you soon Best.💛');
          //  Navigator.of(context).pop();

            //    getRefer(email,add,_refController.text,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          },
              //   style:TextButton.styleFrom( backgroundColor:Colors.black),
              child: Text('Invite', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w400,  ),))
          ),
          Container(
              width: 250,
              decoration: BoxDecoration(
                border: Border(

                //  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),child:
          TextButton(onPressed: () {

            Navigator.of(context).pop();

            //    getRefer(email,add,_refController.text,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          },
              //   style:TextButton.styleFrom( backgroundColor:Colors.black),
              child: Text('Cancle', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w400,  ),))
          ),
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}

ShowDialogAddWallet(BuildContext context)
{
  TextEditingController? _refController= TextEditingController(text: "");
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 390.0,
      width: 250.0,
      //color: bgYellow,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          SizedBox(
            width: 100,
            child:
            Image.asset("assets/images/bird.png", fit: BoxFit.fill),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10,bottom: 15),
              child:
              Center(child:
              Text('Do you have Bsc wallet?',
                style: TextStyle(fontSize:16,fontWeight: FontWeight.w700 ),)
              )
            // )

          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              child:   Text('To receive 5 Yellow tokens,please enter your bsc wallet address in the box,please click the Tutorial button to learn how to get the bsc address',  maxLines: 5,
                style: TextStyle(fontSize:15,fontWeight: FontWeight.w400 ),)
            // )

          ),
          SizedBox(height: 20,),
          Container(
              width: 250,
              decoration: BoxDecoration(
                border: Border(

                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),child:
          TextButton(onPressed: () {
            Navigator.of(context).pop();
            ShowDialogSubmitWallet(context);

            //    getRefer(email,add,_refController.text,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          },
              //   style:TextButton.styleFrom( backgroundColor:Colors.black),
              child: Text('Yes', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w400,  ),))
          ),
          Container(
              width: 250,
              decoration: BoxDecoration(

              ),child:
          TextButton(
              onPressed: () {
         //   Share.share('No');
             Navigator.of(context).pop();

            //    getRefer(email,add,_refController.text,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          },
              //   style:TextButton.styleFrom( backgroundColor:Colors.black),
              child: Text('No', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w400,  ),))
          ),

        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}
ShowDialogSubmitWallet(BuildContext context)
{
  TextEditingController? _addressController= TextEditingController(text: "");
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 360.0,
      width: 250.0,
      //color: bgYellow,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),

          Padding(
              padding: EdgeInsets.only(top: 10,bottom: 15),
              child:
              Center(child:
              Text('JAY wallet',
                style: TextStyle(fontSize:16,fontWeight: FontWeight.w700 ),)
              )
            // )

          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              child:   Text('Please submit your wallet',
                style: TextStyle(fontSize:15,fontWeight: FontWeight.w400 ),)
            // )

          ),
          SizedBox(height: 20,),
      Padding(
        padding: EdgeInsets.only(bottom: 25,left: 15,right: 15),child:
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18.sp),
              hintText: 'Email',
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 12.sp,
                  color: Colors.black26
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.black12, width: 1.5),
              ),

            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Address ';
              }
              // else if( ! EmailValidator.validate(value!))
              // {
              //   return 'Please enter a valid email';
              // }
              return null;
            },
            //  validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
          )),
          Container(
              width: 250,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),child:
          TextButton(
              onPressed: ()
                //   Share.share('No');
                async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? email = prefs.getString("email");
                  if(email!=null&&email.trim().length>0){
                    // var response = await (Services()).getWallet(_emailController!.text,);
                    var response = await (Services()).checkEmail(email,_addressController.text);
                    String j="";

                    if( response['message']!=null &&  response['message']!.trim().length>1 && response['message']!.toString().contains("success")) {
                      customNotification(false, "update done Successfully", MediaQuery
                          .of(context)
                          .size
                          .width, MediaQuery
                          .of(context)
                          .size
                          .height);
                    }
                    // setState(() {
                    //   balance = response["result"]['balance'];
                    // });

                  }

                Navigator.of(context).pop();

                //    getRefer(email,add,_refController.text,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
              },
              //   style:TextButton.styleFrom( backgroundColor:Colors.black),
              child: Text('Add address wallet', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w400,  ),))
          ),
          Container(
              width: 250,
              decoration: BoxDecoration(

              ),child:
          TextButton(
              onPressed: () {
                //   Share.share('No');

                Navigator.of(context).pop();

                //    getRefer(email,add,_refController.text,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
              },
              //   style:TextButton.styleFrom( backgroundColor:Colors.black),
              child: Text('Cancle', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w400,  ),))
          ),
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);


}



