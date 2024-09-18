import 'dart:async';
import 'dart:io';

import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

class BottomBar extends StatefulWidget {
  final int? index;

  const BottomBar({Key? key, this.index}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  DateTime? currentBackPressTime;
  int? currentIndex;
  bool loggedIn = false;

  StreamSubscription? indexSubscription;

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((value) {

      if (value) {
        setState(() {
          loggedIn = value;
        });
      }
    });
    indexSubscription = apiCalls.changeIndex$.listen((value) {
      if (value is int) {
        changeIndex(value);
      }
    });
    if (widget.index != null) {
      setState(() {
        currentIndex = widget.index;
      });
    } else {
      setState(() {
        currentIndex = 1;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (indexSubscription != null) {
      indexSubscription!.cancel();
    }
  }

  changeIndex(int index) async {
    bool loggedIn = await checkLoggedIn();
    if ((index == 3 || index == 4) && !loggedIn) {
      Navigator.pushNamed(context, '/login');
    } else {
      if (index == 3 || index == 4) {
        apiCalls.getUserWallet(context);
      }
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      showIgnore: false,
      showLater: true,
      dialogStyle: Platform.isAndroid
          ? UpgradeDialogStyle.material
          : UpgradeDialogStyle.cupertino,
      upgrader: Upgrader(
        // debugDisplayAlways: true,

        durationUntilAlertAgain: const Duration(minutes: 2),
      ),
      child: Scaffold(
        bottomNavigationBar: Material(
          elevation: 3.0,
          child: Container(
            height: 60.0,
            width: double.infinity,
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bottomBarItem('assets/svg/home.svg', 1),
                bottomBarItem('assets/svg/statistic.svg', 2),
                bottomBarItem('assets/svg/portfolio.svg', 3),
                bottomBarItem('assets/svg/user.svg', 4),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          child: (currentIndex == 1)
              ? Home()
              : (currentIndex == 2)
                  ? Market()
                  : (currentIndex == 3)
                      ? Portfolio()
                      : Profile(),
          onWillPop: () async {
            bool backStatus = onWillPop();
            if (backStatus) {
              exit(0);
            }
            return false;
          },
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  bottomBarItem(activeIconPath, index) {
    return InkWell(
      onTap: () => changeIndex(index),
      child: Padding(
          padding: const EdgeInsets.all(fixPadding * 0.6),
          child: SvgPicture.asset(
            activeIconPath,
            height: 30,
            width: 30,
            color: index == currentIndex ? primaryColor : Colors.grey,
            fit: BoxFit.cover,
          )),
    );
  }

// void requestNotificationPermissionAndroid() async {
//   if (!await Permission.notification.request().isGranted) {
//     await openAppSettings();
//   }
// }
}
