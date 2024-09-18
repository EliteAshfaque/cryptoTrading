import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
class DashboardDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return _homeDrawerView(context);
  }

  Widget _homeDrawerView(context) {
    return Drawer(
      child: ListView(
        padding:  EdgeInsets.zero,
        children: [
          SizedBox(
            height: 70.0,
            child: DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Menu',
                      style: poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 27)),
                  IconButton(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset("assets/svg/close.svg"))
                ],
              ),
            ),
          ),
          ListTile(
            textColor: Colors.white,
            tileColor: primaryColorLight,
            title: const Text('My Profile',style: TextStyle(fontSize:16,fontFamily: 'inter',fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.profile);
            },
          ),
          heightSpace_1,
         /* const Divider(color: Colors.transparent,
              height:  1
          ),*/
          ListTile(
            textColor: Colors.white,
            tileColor: primaryColorLight,
            title: const Text('Add Member',style: TextStyle(fontSize:16,fontFamily: 'inter',fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.addUser);
            },
          ),
          heightSpace_1,
          ListTile(
            textColor: Colors.white,
            tileColor: primaryColorLight,
            title: const Text('Activate Member',style: TextStyle(fontSize:16,fontFamily: 'inter',fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.activateUserByStaking);
            },
          ),
          heightSpace_1,
          ListTile(
            textColor: Colors.white,
            tileColor: primaryColorLight,
            title: const Text('Recent Pin Activity',style: TextStyle(fontSize:16,fontFamily: 'inter',fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.recentPinActivity);
            },
          ),

        ],
      ),
    );
  }


}


