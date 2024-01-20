
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/screens/home_page/home2.dart';
import 'package:redJAY/screens/kartabl/kartabl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class MainTabBar extends StatefulWidget{
  const MainTabBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainTabBarState();

}
class MainTabBarState extends State<MainTabBar> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }
  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: bgGray,
          body: TabBarView(
            controller: _tabController!,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
            Home2(),
            // AddServer(),
             Kartabl(),
              //Setting()
            ],
          ),

          bottomNavigationBar: SafeArea(
              child:
              Container(
                height: 100.sp,
                color: bgGray,
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 6.sp,
                          width: 50.sp,
                          decoration: BoxDecoration(
                              //color: _tabController!.index == 0 ?bgGray : Colors.transparent,
                              color: _tabController!.index == 0 ?bgbuttonRed : Colors.transparent,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                        ),
                        Container(
                          height: 6.sp,
                          width: 50.sp,
                          decoration: BoxDecoration(
                              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                              color: _tabController!.index == 1 ? bgbuttonRed : Colors.transparent,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                        ),

                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(top: BorderSide(width: 0.5, color:bgGray))
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        labelColor: Colors.black,
                        unselectedLabelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: bgGray
                        ),
                        unselectedLabelColor: Colors.black38,
                        onTap: (value){
                          setState(() {});
                        },
                        tabs: [
                          Column(
                            children: [
                              const SizedBox(height: 12),
                              SizedBox(
                                width: 26.sp,
                                height: 26.sp,
                                child: _tabController!.index == 0
                                    ? Image.asset("assets/images/dashboard_select.png",
                                  fit: BoxFit.fill,
                                //  color: bgGray,
                                  color: bgbuttonRed,
                                )
                                    : Image.asset("assets/images/dashboard_unselect.png",
                                  fit: BoxFit.fill,
                                    color: Colors.black38,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text("Home",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  //color: _tabController!.index == 0 ?bgGray : Colors.black38,
                                  color: _tabController!.index == 0 ?bgbuttonRed : Colors.black38,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 12),
                              SizedBox(
                                width: 22.sp,
                                height: 24.sp,
                                child: _tabController!.index == 1
                                    ? Image.asset("assets/images/kartable_select.png",
                                  fit: BoxFit.fill,
                                  //color: bgGray,
                                  color: bgbuttonRed,
                                )
                                    : Image.asset("assets/images/kartable-unselect.png",
                                  fit: BoxFit.fill,
                                  color: Colors.black38,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text("Wallet",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                 // color: _tabController!.index == 1 ?  bgGray : Colors.black38,
                                  color: _tabController!.index == 1 ?  bgbuttonRed : Colors.black38,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),

                          // Column(
                          //   children: [
                          //     const SizedBox(height: 12),
                          //     SizedBox(
                          //       width: 29.sp,
                          //       height: 29.sp,
                          //       child: _tabController!.index == 2
                          //           ? Image.asset("assets/images/setting_select.png",
                          //         fit: BoxFit.fill,
                          //         color: Colors.black87,
                          //       )
                          //           : Image.asset("assets/images/setting_unselect.png",
                          //         fit: BoxFit.fill,
                          //         color: Colors.black38,
                          //       ),
                          //     ),
                          //     const SizedBox(height: 8),
                          //     Text("تنظیمات",
                          //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          //         color: _tabController!.index == 2 ? Colors.black87 : Colors.black38,
                          //         fontSize: 15.sp,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }

}
