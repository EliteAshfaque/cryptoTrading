import 'dart:async';
import 'dart:io';
import 'package:cryptox/common/commonSocketStruct.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/account/FiatDepositHistory.dart';
import 'package:cryptox/pages/account/bank_deposit.dart';
import 'package:cryptox/pages/account/depositEntries.dart';
import 'package:cryptox/pages/account/orderEntries/cash_deposit_history.dart';
import 'package:cryptox/pages/account/orderEntries/orderEntries.dart';
import 'package:cryptox/pages/account/withdrawalEntries.dart';
import 'package:cryptox/pages/portfolio/cryptoAction.dart';
import 'package:cryptox/pages/profile/support.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cryptox/pages/alerts/notification.dart' as notify;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'common/apiCalls.dart';
import 'common/check_internet_controller.dart';
import 'constant/MyHttpOverides.dart';
import 'indX/routes/AppPages.dart';
import 'indX/view_controller_binding/splash/SplashBinding.dart';
import 'pages/account/allTransactions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();

  CoinListingSocketStruct(
      selectedFiat: FiatType.USDT, tokenSocket: apiCalls.commonCoinSocket$);

  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    // runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
    Get.put(CheckInternetController());

    runApp(MyApp());
  });
}

var _kTestingCrashlytics = true;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Requesting permissions on Android 13 or higher...
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  late InitializationSettings initializationSettings;

  // BackGround and terminated state notifications are handled by channel...
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
  );
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }
    /*if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }*/
  }

  @override
  void initState() {
    super.initState();
    _initializeFlutterFire();

    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);

    if (Platform.isIOS) {
      requestForegroundNotificationPermissionIOS();
      getNotificationPermissionIOS();
    }

    flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
            onSelectNotification: selectNotification)
        .then((value) {
      // Requesting Permission for android 13 and higher...
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();

      // creating channel...
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel)
          .then((value) {
        FirebaseMessaging.instance.getToken().then((token) {
          if (kDebugMode) {
            print("DEVICE TOKEN " + token.toString());
          }
          setValueForKey(mobileTokenKey, token.toString());
        });
      });
    });

    setupInteractedMessage();

    // If your own application is in the foreground, the Firebase Android SDK will
    // block displaying any FCM notification no matter what Notification Channel
    // has been set. We can however still handle an incoming notification message
    // via the onMessage stream
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("MESSAGE ON NOTIFICATION " +
            message.notification!.hashCode.toString());
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  icon: android.smallIcon,
                  styleInformation: BigTextStyleInformation('')
                  // other properties...
                  ),
            ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectNotification(String? payload) async {
    await navigatorKey.currentState!.push(PageTransition(
        type: PageTransitionType.fade, child: notify.Notification()));
  }

  @override
  Widget build(BuildContext context) {
    // DependencyInjection.init(context);

    return GetMaterialApp(
      title: '1fx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        fontFamily: 'Montserrat',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: greyColor,
        ),
      ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/login': (context) => Login(),
        '/notification': (context) => notify.Notification(),
        '/crypto_action': (context) => CryptoAction(),
        '/fiat_deposit': (context) => FiatDepositHistory(),
        '/deposit': (context) => DepositEntries(),
        '/withdrawal': (context) => WithdrawalEntries(),
        '/order': (context) => OrderEntries(),
        '/ledger': (context) => AllTransactions(),
        '/inr_withdrawal': (context) => Withdraw(),
        '/inr_deposit': (context) => Deposit(),
        '/help_and_support': (context) => Support(),
        '/edit_profile': (context) => EditProfile(),
        '/bank_deposit': (context) => CashDepositPage(),
        '/cdm_history': (context) => CashDepositHistory(),
      },
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
    );
  }

  // triggers when app is in terminated state i.e. when notification is clicked...
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (kDebugMode) {
      print("IN HANDLE MESSAGE ");
    }
    navigatorKey.currentState!.push(PageTransition(
        type: PageTransitionType.fade, child: notify.Notification()));
  }

  Future<void> requestForegroundNotificationPermissionIOS() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  getNotificationPermissionIOS() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
