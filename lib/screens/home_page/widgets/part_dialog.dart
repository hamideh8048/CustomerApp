
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/PartModel.dart';
import 'package:redJAY/services/services.dart';

TextEditingController? _titleController=TextEditingController();
TextEditingController? _priceController=TextEditingController();

createPartBussiness(BuildContext context,String token,String lang, String projectId,String bussineessId,String title,String price)
async {
  try {

    var response = await (Services()).createPartBusiness(
            token,
            bussineessId,
            lang!,
            projectId!,
           title,
            price,
          "4",
           );
        //   var response = await (Services()).createPartBusiness(token1!,widget.bussinessModel.id,lang!,projectId!,widget.bussinessModel.title,"3000",count.toString(),uri,extension,name,alt,size,data,type);
        if (response['statusCode'] != null && response['statusCode'] == 200) {
              String bussinessId = "0";
    if (response['data']['id'] != null) {
      bussinessId = response['data']['id'].toString();
    }
              PartModel part   =  PartModel.fromStringStatus(
       title, "", int.parse(bussinessId), price);
         // Navigator.pop(context, price);
          Navigator.pop(context, part);
        }
        else {
          Navigator.pop(context,null);
          customNotification(true, response["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);

        }
        _priceController!.text="";
        _titleController!.text="";
      }
catch (error) {
print(error);

}
    }



Future< PartModel?> openPartResultDialog(BuildContext context, double sum ,double price,String token,String lang,String projectId,String bussineessId) async {
  return showDialog< PartModel?>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content:
        Container(

            child:
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            width: MediaQuery.of(context).size.width * 0.8,
            child:
            Column(
              children: [
              Text("Part Info",
              maxLines: 7,
              style: const TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: 15 ,
                color:greyColor3   ,
                //  fontWeight: FontWeight.bold,
              ),


            ),
              SizedBox(height: 20,),
              SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child:
                // Padding(
                // padding:  EdgeInsets.only(left:20,right: 20,top:20),
               // child:
                TextFormField(
                controller: _titleController,
                style:TextStyle(color:greyColor3 ,fontSize:14 ,),
                onTap: (){

                },
                validator: (value) {
                if (value == null || value.isEmpty) {
                return "";
                //  return 'Please enter proje ';
                }
                return null;
                },
                // style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: "Part Title",
                hintStyle:TextStyle(color:greyColor3 ),
                labelStyle:TextStyle(color:greyColor3 ,),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: greyColor3 ),
                ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(
                color: greyColor3 , width: 1.5),
                ),
                labelText: "Part Title",
                alignLabelWithHint: false,
                filled: true,
                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                ),
                ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child:
                  // Padding(
                  // padding:  EdgeInsets.only(left:20,right: 20,top:20),
                  // child:

                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    style:TextStyle(color:greyColor3 ,fontSize:14 ,),
                    onTap: (){

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "";
                        //  return 'Please enter proje ';
                      }
                      return null;
                    },
                    // style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "Price",
                      hintStyle:TextStyle(color:greyColor3 ),
                      labelStyle:TextStyle(color:greyColor3 ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: const BorderSide(
                            color: greyColor3 , width: 1.5),
                      ),

                      labelText: "Price",
                      alignLabelWithHint: false,
                      filled: true,
                      // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [

                    Expanded(
                      flex: 1,

                        child:
                        GestureDetector(
                            onTap: (){
                         if(_priceController!.text!=null &&_priceController!.text!="0" &&_priceController!.text.length>0&& _titleController!.text!=null &&_titleController!.text.length>0&&price>=sum+double.parse(_priceController!.text)) {
                            createPartBussiness(context, token, lang, projectId, bussineessId, _titleController!.text, _priceController!.text);

                            }else
                              {    Navigator.pop(context, null);}
                         _priceController!.text="";
                         _titleController!.text="";
                         },
                            child:

                            Container(
                              width: 80,
                              height: 50.sp,
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
                            )
                          ,))
            ])
                        ]),
                      )));



            // GetPersianDate(dateChangeListener: (String date) {
            //   setState2(() {
            //
            //   });
            // })

    },
  );
}
