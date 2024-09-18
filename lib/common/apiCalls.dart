import 'dart:async';
import 'dart:convert';

import 'package:cryptox/Interceptors/TokenInterceptor.dart';
import 'package:cryptox/api/Order/placeOrder/placeOrder.dart';
import 'package:cryptox/api/Order/placedOrderEntries/placeOrderEntries.dart';
import 'package:cryptox/api/announcement/getAnnouncements/getAnnouncements.dart';
import 'package:cryptox/api/bank/adminBanks/adminBanks.dart';
import 'package:cryptox/api/bank/bankList/bankList.dart';
import 'package:cryptox/api/bank/userBank/userBank.dart';
import 'package:cryptox/api/banner/getBanner/getBanner.dart';
import 'package:cryptox/api/coinTransactionLogs/transactionLogHistory.dart';
import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/api/coins/ledger/ledgerEntries.dart';
import 'package:cryptox/api/coins/masterCoinList/getMasterCoinList.dart';
import 'package:cryptox/api/coins/orderBook/orderBook.dart';
import 'package:cryptox/api/funds/allCoinsFund/allCoinsFund.dart';
import 'package:cryptox/api/funds/generateUserAddress/generateUserAddress.dart';
import 'package:cryptox/api/funds/withdrawalinr/withdrawalInr.dart';
import 'package:cryptox/api/helpDesk/allConversations/allConversations.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:cryptox/api/kyc/kycId/kycId.dart';
import 'package:cryptox/api/masterAuth/allMasterAuth/allMasterAuth.dart';
import 'package:cryptox/api/notification/getAllUserNotifications/getAllNotifications.dart';
import 'package:cryptox/api/orderFills/completedOrderEntries/completedOrderEntries.dart';
import 'package:cryptox/api/request/allRequest/allRequests.dart';
import 'package:cryptox/api/request/createRequest/createRequest.dart';
import 'package:cryptox/api/upload/fileUpload.dart';
import 'package:cryptox/api/user/activityLogs/activityLogs.dart';
import 'package:cryptox/api/user/enableAuth/enableAuth.dart';
import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:cryptox/api/user/userAdditionalDetails/userAdditionalDetails.dart';
import 'package:cryptox/api/user/verifyAuth/verifyAuth.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/widget/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import '../api/base.dart';
import '../api/generare_unique/generate_unique_code_struct.dart';
import '../api/uniqueCode/unique_code.dart';
import '../util/loader.dart';

class ApiCalls {
  BehaviorSubject walletSubject$ = new BehaviorSubject<dynamic>();
  BehaviorSubject orderBookSubject$ = new BehaviorSubject<dynamic>();
  BehaviorSubject allCoinsSubject$ = new BehaviorSubject<dynamic>();
  BehaviorSubject userCryptoWithdrawal$ = new BehaviorSubject<dynamic>();
  PublishSubject userOrder$ = new PublishSubject<dynamic>();
  PublishSubject userDetails$ = new PublishSubject<dynamic>();
  PublishSubject userCompletedOrderEntries$ = new PublishSubject<dynamic>();
  PublishSubject<CoinListings> commonCoinSocket$ =
      new PublishSubject<CoinListings>();
  PublishSubject userPlacedOrderEntries$ = new PublishSubject<dynamic>();
  PublishSubject userCancelOrderEntries$ = new PublishSubject<dynamic>();
  PublishSubject userDeposits$ = new PublishSubject<dynamic>();
  PublishSubject coinTransactions$ = new PublishSubject<dynamic>();
  PublishSubject ledgerEntries$ = new PublishSubject<dynamic>();
  PublishSubject uploadDoc$ = new PublishSubject<dynamic>();
  PublishSubject kycId$ = new PublishSubject<dynamic>();
  PublishSubject userBank$ = new PublishSubject<dynamic>();
  PublishSubject bankList$ = new PublishSubject<dynamic>();
  PublishSubject iUser$ = new PublishSubject<dynamic>();
  PublishSubject allMasterAuth$ = new PublishSubject<dynamic>();
  PublishSubject dummyMasterAuth$ = new PublishSubject<dynamic>();
  PublishSubject masterCoinList$ = new PublishSubject<dynamic>();
  PublishSubject otpResp$ = new PublishSubject<dynamic>();
  PublishSubject userLogs$ = new PublishSubject<dynamic>();
  PublishSubject adminBanks$ = new PublishSubject<dynamic>();
  PublishSubject inrRequest$ = new PublishSubject<dynamic>();
  PublishSubject generateUniquesCode$ = new PublishSubject<dynamic>();
  PublishSubject getUniquesCode$ = new PublishSubject<dynamic>();
  PublishSubject inrWithdrawalRequest$ = new PublishSubject<dynamic>();
  PublishSubject userDepositAddress$ = new PublishSubject<dynamic>();
  PublishSubject depositCrypto$ = new PublishSubject<String>();
  PublishSubject funds$ = new PublishSubject<dynamic>();
  PublishSubject ticket$ = new PublishSubject<dynamic>();
  PublishSubject reply$ = new PublishSubject<dynamic>();
  PublishSubject conversations$ = new PublishSubject<dynamic>();
  PublishSubject inrCoinSocket$ = new PublishSubject<dynamic>();
  PublishSubject usdtCoinSocket$ = new PublishSubject<dynamic>();
  PublishSubject notification$ = new PublishSubject<dynamic>();
  PublishSubject updatePhone$ = new PublishSubject<dynamic>();
  PublishSubject cancelOrder$ = new PublishSubject<dynamic>();
  PublishSubject banner$ = new PublishSubject<dynamic>();
  PublishSubject deleteUser$ = new PublishSubject<dynamic>();
  PublishSubject announcement$ = new PublishSubject<dynamic>();
  PublishSubject last24HourVolume$ = new PublishSubject<dynamic>();
  PublishSubject notificationUpdate$ = new PublishSubject<dynamic>();
  PublishSubject referrals$ = new PublishSubject<dynamic>();
  PublishSubject changeIndex$ = new PublishSubject<int>();

  Future<bool> getUserWallet(BuildContext context) async {
    List<Wallet> wallets = [];
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var walletData = await client.getUserWallet();
      if (kDebugMode) {
        print(jsonEncode(walletData));
      }
      if (walletData.success) {
        wallets = (walletData.result['message'] as List)
            .map((trades) => Wallet.fromJson(trades))
            .toList();
        if (!walletSubject$.isClosed) walletSubject$.add(wallets);
        flag = true;
      } else {
        if (!walletSubject$.isClosed) walletSubject$.add("");
        // showToast(walletData.result['error'],
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      return flag;
    } catch (e) {
      if (!walletSubject$.isClosed) walletSubject$.add("");
      if (e is DioError) {
        // showToast(e.message.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      //print("ERROR " + e.toString());
      return false;
    }
  }

  Future getOrderBookData(String symbol, String fiat) async {
    print('This is Executing when  trying to call the api');
    final dio = Dio();
    final client = RestClient(dio);
    try {
      var orderData = await client.getOrderBook(symbol, fiat);
      AllOrderResponse allOrders = new AllOrderResponse();
      if (kDebugMode) {
        print(jsonEncode(orderData));
      }
      if (orderData.success) {
        // var buy = jsonDecode(orderData.result['message']['buy']);
        // var sell = jsonDecode(orderData.result['message']['sell']);
        // print(orderData.result['message']['buy'][0]['totalQty'].runtimeType);
        allOrders.buy = (orderData.result['message']['buy'] as List)
            .map((order) => OrderResponse.fromJson(order))
            .toList();
        allOrders.sell = (orderData.result['message']['sell'] as List)
            .map((order) => OrderResponse.fromJson(order))
            .toList();
        if (kDebugMode) {
          print("vnvne " + orderBookSubject$.isClosed.toString());
        }
        if (!orderBookSubject$.isClosed) orderBookSubject$.add(allOrders);
      } else {
        if (!orderBookSubject$.isClosed) orderBookSubject$.add("");
        showToast(orderData.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!orderBookSubject$.isClosed) orderBookSubject$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("ERROR " + e.toString());
    }
  }

  Future createUserOrder(Object body, BuildContext context) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.interceptors.add(TokenInterceptor(context: context));
    try {
      var orderData = await client.createOrder(body);
      if (kDebugMode) {
        print(jsonEncode(orderData));
      }
      if (orderData.success) {
        PlaceOrderStruct order =
            PlaceOrderStruct.fromJson(orderData.result['message']);
        if (!userOrder$.isClosed) userOrder$.add(order);
      } else {
        if (!userOrder$.isClosed) userOrder$.add("");
        showToast(orderData.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!userOrder$.isClosed) userOrder$.add("");
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("ERROR ON PLACING ORDER " + e.toString());
    }
  }

  Future getCoins() async {
    List<CoinListings> coins = [];
    final dio = Dio();

    final client = RestClient(dio);
    try {
      var allCoins = await client.getAllCoins();

      if (kDebugMode) {
        print(jsonEncode(allCoins));
      }
      if (allCoins.success) {
        coins = (allCoins.result['message'] as List)
            .map((coin) => CoinListings.fromJson(coin))
            .toList();
        if (kDebugMode) {
          print("Coins " + coins.length.toString());
        }
        if (!allCoinsSubject$.isClosed) allCoinsSubject$.add(coins);
      } else {
        showToast(allCoins.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!allCoinsSubject$.isClosed) allCoinsSubject$.add("");
      }
    } catch (e) {
      if (!allCoinsSubject$.isClosed) allCoinsSubject$.add("");
      if (e is DioError) {
        // showToast(e.message.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      // showToast(e.toString(),
      //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      // print('This error is occurs from this points please tell${e.toString()}');
      //print("GET COINS ERROR " + e.toString());
    }
  }

  Future<int> getUserDepositEntries(Map obj, BuildContext context) async {
    List<RequestStruct> deposits = [];
    int totalCount = 1;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getAllDeposits(obj['page'], obj['status']);
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        deposits = (allEntries.result['message']['data'] as List)
            .map((entry) => RequestStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER DEPOSIT ENTRIES " + deposits.length.toString());
        }
        if (!userDeposits$.isClosed) {
          userDeposits$.add(deposits);
          int count = allEntries.result['message']['totalCount'];
          totalCount = count == 0 ? 1 : count;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userDeposits$.isClosed) {
          userDeposits$.add("");
        }
      }
      return totalCount;
    } catch (e) {
      if (!userDeposits$.isClosed) userDeposits$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return 1;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER DEPOSIT ERROR " + e.toString());
      return 1;
    }
  }

  Future<int> getTransactionHistoryCoin(Map obj, BuildContext context) async {
    List<TransactionLogsStruct> deposits = [];
    int totalCount = 1;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getCoinTransactionHistory(
          obj['page'], obj['symbol'], obj['requestType'], obj['status']);
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        deposits = (allEntries.result['message']['data'] as List)
            .map((entry) => TransactionLogsStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER DEPOSIT ENTRIES " + deposits.length.toString());
        }
        if (!coinTransactions$.isClosed) {
          coinTransactions$.add(deposits);
          int count = allEntries.result['message']['totalCount'];
          totalCount = count == 0 ? 1 : count;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!coinTransactions$.isClosed) {
          coinTransactions$.add("");
        }
      }
      return totalCount;
    } catch (e) {
      if (!coinTransactions$.isClosed) coinTransactions$.add("");
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER DEPOSIT ERROR " + e.toString());
      return 1;
    }
  }

  Future<int> getUserWithdrawalHistory(Map obj, BuildContext context) async {
    List<TransactionLogsStruct> deposits = [];
    int totalCount = 1;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getCoinTransactionHistory(
          obj['page'], obj['symbol'], obj['requestType'], obj['status']);
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        deposits = (allEntries.result['message']['data'] as List)
            .map((entry) => TransactionLogsStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER DEPOSIT ENTRIES " + deposits.length.toString());
        }
        if (!userCryptoWithdrawal$.isClosed) {
          userCryptoWithdrawal$.add(deposits);
          int count = allEntries.result['message']['totalCount'];
          totalCount = count == 0 ? 1 : count;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userCryptoWithdrawal$.isClosed) {
          userCryptoWithdrawal$.add("");
        }
      }
      return totalCount;
    } catch (e) {
      if (!userCryptoWithdrawal$.isClosed) userCryptoWithdrawal$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return 1;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER DEPOSIT ERROR " + e.toString());
      return 1;
    }
  }

  Future<int> getUserPlacedOrderEntries(Map obj, BuildContext context) async {
    List<OrderSchedulerStruct> orders = [];
    int totalCount = 1;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getOrderPlacedCancelledEntries(obj['page'],
          obj['searchTerm'], obj['type'], obj['status'], obj['searchFilter']);
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        orders = (allEntries.result['message']['data'] as List)
            .map((entry) => OrderSchedulerStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER PLACED ORDER ENTRIES " + orders.length.toString());
        }
        if (!userPlacedOrderEntries$.isClosed) {
          userPlacedOrderEntries$.add(orders);
          int count = allEntries.result['message']['totalCount'];
          totalCount = count == 0 ? 1 : count;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userPlacedOrderEntries$.isClosed) {
          userPlacedOrderEntries$.add("");
        }
      }
      return totalCount;
    } catch (e) {
      if (!userPlacedOrderEntries$.isClosed) userPlacedOrderEntries$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return 1;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER PLACED ORDER ERROR " + e.toString());
      return 1;
    }
  }

  Future<int> getUserCancelOrderEntries(Map obj, BuildContext context) async {
    List<OrderSchedulerStruct> orders = [];
    int totalCount = 1;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getCancelledEntries(obj['page'],
          obj['searchTerm'], obj['type'], obj['status'], obj['searchFilter']);
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        orders = (allEntries.result['message']['data'] as List)
            .map((entry) => OrderSchedulerStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER PLACED ORDER ENTRIES " + orders.length.toString());
        }
        if (!userCancelOrderEntries$.isClosed) {
          userCancelOrderEntries$.add(orders);
          int count = allEntries.result['message']['totalCount'];
          totalCount = count == 0 ? 1 : count;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userCancelOrderEntries$.isClosed) {
          userCancelOrderEntries$.add("");
        }
      }
      return totalCount;
    } catch (e) {
      if (!userCancelOrderEntries$.isClosed) userCancelOrderEntries$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return 1;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER PLACED ORDER ERROR " + e.toString());
      return 1;
    }
  }

  Future<int> getUserCompletedOrderEntries(
      Map obj, BuildContext context) async {
    List<OrderFillsStruct> orders = [];
    int totalCount = 1;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getCompletedOrderEntries(obj['page'],
          obj['searchTerm'], obj['type'], obj['symbol'], obj['searchFilter']);
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        orders = (allEntries.result['message']['data'] as List)
            .map((entry) => OrderFillsStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER PLACED ORDER ENTRIES " + orders.length.toString());
        }
        if (!userCompletedOrderEntries$.isClosed) {
          userCompletedOrderEntries$.add(orders);
          int count = allEntries.result['message']['totalCount'];
          totalCount = count == 0 ? 1 : count;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userCompletedOrderEntries$.isClosed) {
          userCompletedOrderEntries$.add("");
        }
      }
      return totalCount;
    } catch (e) {
      if (!userCompletedOrderEntries$.isClosed)
        userCompletedOrderEntries$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return 1;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER PLACED ORDER ERROR " + e.toString());
      return 1;
    }
  }

  Future<int> getAllLedgerTransactions(Map obj, BuildContext context) async {
    List<LedgerStruct> transactionList = [];
    int totalCount = 1;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries =
          await client.getLedgerEntries(obj['page'], obj['symbol']);
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        transactionList = (allEntries.result['message']['data'] as List)
            .map((entry) => LedgerStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER LEDGER ENTRIES " + transactionList.length.toString());
        }
        if (!ledgerEntries$.isClosed) {
          ledgerEntries$.add(transactionList);
          int count = allEntries.result['message']['totalCount'];
          totalCount = count == 0 ? 1 : count;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!ledgerEntries$.isClosed) {
          ledgerEntries$.add("");
        }
      }
      return totalCount;
    } catch (e) {
      if (!ledgerEntries$.isClosed) ledgerEntries$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return 1;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER LEDGER ENTRIES ERROR " + e.toString());
      return 1;
    }
  }

  Future getDetailsOfUser(BuildContext context) async {
    UserDetailsStruct userDetail;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getUserDetails();
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        userDetail = UserDetailsStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("USER DETAILS " + userDetail.toString());
        }
        if (!userDetails$.isClosed) {
          userDetails$.add(userDetail);
        }
      } else {
        if (details.result['error'] != "No user Details Found") {
          showToast(details.result['error'],
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        }
        if (!userDetails$.isClosed) {
          userDetails$.add("");
        }
      }
    } catch (e) {
      if (!userDetails$.isClosed) userDetails$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER DETAILS ERROR " + e.toString());
    }
  }

  Future submitDetailsOfUser(Object obj, BuildContext context) async {
    UserDetailsStruct userDetail;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.submitUserDetails(obj);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        userDetail = UserDetailsStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("SUBMIT USER DETAILS " + userDetail.toString());
        }
        if (!userDetails$.isClosed) {
          userDetails$.add(userDetail);
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userDetails$.isClosed) {
          userDetails$.add("");
        }
      }
    } catch (e) {
      if (!userDetails$.isClosed) userDetails$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("SUBMIT USER DETAILS ERROR " + e.toString());
    }
  }

  Future uploadUserDocs(Map<String, dynamic> obj, BuildContext context) async {
    DocumentsStruct doc;
    final dio = Dio();
    FormData formData = new FormData.fromMap(obj);
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['boundary'] = formData.boundary;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details =
          await client.uploadDoc(obj['image'], obj['data'], obj['type']);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        doc = DocumentsStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("UPLOADED DOC DETAILS " + doc.toString());
        }
        if (!uploadDoc$.isClosed) {
          uploadDoc$.add(doc);
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!uploadDoc$.isClosed) {
          uploadDoc$.add("");
        }
      }
    } catch (e) {
      if (!uploadDoc$.isClosed) uploadDoc$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("UPLOADED DOC ERROR " + e.toString());
    }
  }

  Future getUserKycDetails(BuildContext context) async {
    KycStruct kycDetails;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getKycId();
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        kycDetails = KycStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("KYC DETAILS " + kycDetails.toString());
        }
        if (!kycId$.isClosed) {
          kycId$.add(kycDetails);
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!kycId$.isClosed) {
          kycId$.add("");
        }
      }
    } catch (e) {
      if (!kycId$.isClosed) kycId$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("KYC DETAILS ERROR " + e.toString());
    }
  }

  Future submitUserKycDetails(Object obj, BuildContext context) async {
    KycStruct kycDetails;
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.createKycEntry(obj);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        kycDetails = KycStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("KYC DETAILS " + kycDetails.toString());
        }
        if (!kycId$.isClosed) {
          kycId$.add(kycDetails);
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!kycId$.isClosed) {
          kycId$.add("");
        }
      }
    } catch (e) {
      if (!kycId$.isClosed) kycId$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("KYC DETAILS ERROR " + e.toString());
    }
  }

  Future<bool> getUserBankDetails(BuildContext context) async {
    List<UserBankStruct> bankDetails = [];
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getUserBank();
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        bankDetails = (allEntries.result['message'] as List)
            .map((entry) => UserBankStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("USER BANK " + bankDetails.toString());
        }
        if (!userBank$.isClosed) {
          userBank$.add(bankDetails);
          flag = true;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userBank$.isClosed) {
          userBank$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!userBank$.isClosed) userBank$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER BANK ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getBankList(BuildContext context) async {
    List<BankListStruct> bankList = [];
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var allEntries = await client.getAllBanks();
      if (kDebugMode) {
        print(jsonEncode(allEntries));
      }
      if (allEntries.success) {
        bankList = (allEntries.result['message'] as List)
            .map((entry) => BankListStruct.fromJson(entry))
            .toList();
        if (kDebugMode) {
          print("BANK LIST " + bankList.toString());
        }
        if (!bankList$.isClosed) {
          bankList$.add(bankList);
          flag = true;
        }
      } else {
        showToast(allEntries.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!bankList$.isClosed) {
          bankList$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!bankList$.isClosed) bankList$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("BANK LIST " + e.toString());
      return false;
    }
  }

  Future<bool> createBankForUser(Object obj, BuildContext context) async {
    UserBankStruct bank;
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.createUserBank(obj);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        bank = UserBankStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("CREATED USER BANK " + details.toString());
        }
        if (!userBank$.isClosed) {
          userBank$.add(bank);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userBank$.isClosed) {
          userBank$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!userBank$.isClosed) userBank$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("CREATED USER BANK ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> verifyUtrForUser(Object obj, BuildContext context) async {
    UserBankStruct bank;
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.verifyUtr(obj);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        bank = UserBankStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("VERIFY UTR " + details.toString());
        }
        if (!userBank$.isClosed) {
          userBank$.add(bank);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userBank$.isClosed) {
          userBank$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!userBank$.isClosed) userBank$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("VERIFY UTR ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> updateUserMobileToken(Object obj, BuildContext context) async {
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.refreshUserMobilToken(obj);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        if (kDebugMode) {
          print("USER REFRESH TOKEN RESP " + details.result['message']);
        }
        flag = true;
      } else {
        // showToast(details.result['error'],
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      return flag;
    } catch (e) {
      if (e is DioError) {
        // showToast(e.message.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      // showToast(e.toString(),
      //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("USER REFRESH TOKEN ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getIUserDetails(BuildContext context) async {
    IUserStruct user;
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getIUser();
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        user = IUserStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("IUSER DETAILS " + details.toString());
        }
        if (!iUser$.isClosed) {
          iUser$.add(user);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!iUser$.isClosed) {
          iUser$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!iUser$.isClosed) iUser$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("IUSER DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future getNewReferrals(BuildContext context) async {
    final dio = Dio();
    List<IUserStruct> referrals = [];
    final client = RestClient(dio);
    dio.interceptors.add(TokenInterceptor(context: context));
    try {
      var referralsData = await client.getReferrals();
      if (kDebugMode) {
        print(jsonEncode(referralsData));
      }
      if (referralsData.success) {
        referrals = (referralsData.result['message'] as List)
            .map((entry) => IUserStruct.fromJson(entry))
            .toList();
        if (!referrals$.isClosed) referrals$.add(referrals);
      } else {
        if (!referrals$.isClosed) referrals$.add("");
        showToast(referralsData.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!referrals$.isClosed) referrals$.add("");
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("ERROR GETTING REFERRALS " + e.toString());
    }
  }

  Future<bool> getMasterAuth(BuildContext context) async {
    DummyMasterAuthStruct allAuths;
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getAllMasterAuth();
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        allAuths = DummyMasterAuthStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("ALL AUTH DETAILS " + details.toString());
        }
        if (!allMasterAuth$.isClosed) {
          allMasterAuth$.add(allAuths);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!allMasterAuth$.isClosed) {
          allMasterAuth$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!allMasterAuth$.isClosed) allMasterAuth$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("ALL AUTH ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> enableUserAuth(String type, BuildContext context) async {
    MasterAuthStruct auth;
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.enableAuth(type);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        auth = MasterAuthStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("ENABLE AUTH DETAILS " + details.toString());
        }
        if (!dummyMasterAuth$.isClosed) {
          dummyMasterAuth$.add(auth);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!dummyMasterAuth$.isClosed) {
          dummyMasterAuth$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!dummyMasterAuth$.isClosed) dummyMasterAuth$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("ENABLE AUTH ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> verifyUserAuth(Object obj, BuildContext context) async {
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.verifyOtp(obj);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        var encode = VerifyAuthStruct.fromJson(details.result['message']);
        if (kDebugMode) {
          print("VERIFY USER AUTH DETAILS " + encode.type.toString());
        }
        if (encode.type == MasterAuthType.google_auth.name) {
          if (!otpResp$.isClosed) {
            otpResp$.add(encode.data);
            flag = true;
          }
        } else {
          IUserStruct user;
          user = IUserStruct.fromJson(encode.data);
          if (!iUser$.isClosed) {
            iUser$.add(user);
            flag = true;
          }
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!otpResp$.isClosed) {
          otpResp$.add("");
        }
        if (!iUser$.isClosed) {
          iUser$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!otpResp$.isClosed) otpResp$.add("");
      if (!iUser$.isClosed) iUser$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("VERIFY USER AUTH ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> updateUserSettings(Object obj, BuildContext context) async {
    final dio = Dio();
    IUserStruct user;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.updateUserSettings(obj);
      print(jsonEncode(details));
      if (details.success) {
        print("UPDATE USER DETAILS " + details.toString());
        user = IUserStruct.fromJson(details.result['message']);
        if (!iUser$.isClosed) {
          iUser$.add(user);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!iUser$.isClosed) {
          iUser$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!iUser$.isClosed) iUser$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("UPDATE USER DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getUserAuthLogs(BuildContext context) async {
    final dio = Dio();
    List<ActivityLogsStruct> logs = [];
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getUserLogs();
      print(jsonEncode(details));
      if (details.success) {
        print("USER LOGS DETAILS " + details.toString());
        logs = (details.result['message'] as List)
            .map((entry) => ActivityLogsStruct.fromJson(entry))
            .toList();
        if (!userLogs$.isClosed) {
          userLogs$.add(logs);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userLogs$.isClosed) {
          userLogs$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!userLogs$.isClosed) userLogs$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("USER LOGS DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getDepositBankAdmin(BuildContext context) async {
    final dio = Dio();
    List<AdminBanksStruct> banks = [];
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getAdminBanks();
      print(jsonEncode(details));
      if (details.success) {
        print("ADMIN BANK DETAILS " + details.toString());
        banks = (details.result['message'] as List)
            .map((entry) => AdminBanksStruct.fromJson(entry))
            .toList();
        if (!adminBanks$.isClosed) {
          adminBanks$.add(banks);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!adminBanks$.isClosed) {
          adminBanks$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!adminBanks$.isClosed) adminBanks$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ADMIN BANK DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> submitInrRequest(Object obj, BuildContext context) async {
    final dio = Dio();
    FiatRequestStruct request;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.createInrRequest(obj);
      print(jsonEncode(details));
      if (details.success) {
        print("USER REQUEST DETAILS " + details.toString());
        request = FiatRequestStruct.fromJson(details.result['message']);
        if (!inrRequest$.isClosed) {
          inrRequest$.add(request);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!inrRequest$.isClosed) {
          inrRequest$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!inrRequest$.isClosed) inrRequest$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("USER REQUEST DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> withdrawalInrRequest(Object obj, BuildContext context) async {
    final dio = Dio();
    WithdrawalInrResp request;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.withdrawalInr(obj);
      print(jsonEncode(details));
      if (details.success) {
        print("USER INR WITHDRAWAL DETAILS " + details.toString());
        request = WithdrawalInrResp.fromJson(details.result['message']);
        if (!inrWithdrawalRequest$.isClosed) {
          inrWithdrawalRequest$.add(request);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!inrWithdrawalRequest$.isClosed) {
          inrWithdrawalRequest$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!inrWithdrawalRequest$.isClosed) inrWithdrawalRequest$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("USER INR WITHDRAWAL ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getUserAddress(
      String uniqId, String symbol, BuildContext context) async {
    final dio = Dio();
    UserAddressStruct address;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.generateUserAddress(uniqId, symbol);
      print(jsonEncode(details));
      if (details.success) {
        print("USER ADDRESS " + details.toString());
        address = UserAddressStruct.fromJson(details.result['message']);
        if (!userDepositAddress$.isClosed) {
          userDepositAddress$.add(address);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!userDepositAddress$.isClosed) {
          userDepositAddress$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!inrWithdrawalRequest$.isClosed) inrWithdrawalRequest$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("USER ADDRESS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> depositCryptoAtAddress(
      String uniqId, Object obj, BuildContext context) async {
    final dio = Dio();
    String res;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.depositCrypto(uniqId, obj);
      print(jsonEncode(details));
      if (details.success) {
        print("DEPOSIT CRYPTO " + details.toString());
        res = details.result['message'].toString();
        showToast('${res}',
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!depositCrypto$.isClosed) {
          depositCrypto$.add(res);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!depositCrypto$.isClosed) {
          depositCrypto$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!depositCrypto$.isClosed) depositCrypto$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("DEPOSIT CRYPTO ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getAllCoinsToFund(String page, BuildContext context) async {
    final dio = Dio();
    List<FundsStruct> res = [];
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.allCoinsFunds(page);
      print(jsonEncode(details));
      // print(details.result['message']['allFunds']);
      if (details.success) {
        // var decode = FundsDummyStruct.fromJson(details.result['message']);
        // // print("DECODE " + decode.allFunds![0].canWithdrawal.toString());
        // // res = decode.allFunds!.map((entry) => FundsStruct.fromJson(entry))
        // //     .toList();
        if (!funds$.isClosed) {
          funds$.add((details.result['message']['allFunds'] as List)
              .map((entry) => FundsStruct.fromJson(entry))
              .toList());
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!funds$.isClosed) {
          funds$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!funds$.isClosed) funds$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ALL COINS FUND ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> withdrawalCryptoRequest(
      String network, Object obj, BuildContext context) async {
    final dio = Dio();
    WithdrawalInrResp request;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.withdrawalCrypto(network, obj);
      print(jsonEncode(details));
      if (details.success) {
        print("USER CRYPTO WITHDRAWAL DETAILS " + details.toString());
        request = WithdrawalInrResp.fromJson(details.result['message']);
        if (!inrWithdrawalRequest$.isClosed) {
          inrWithdrawalRequest$.add(request);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!inrWithdrawalRequest$.isClosed) {
          inrWithdrawalRequest$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!inrWithdrawalRequest$.isClosed) inrWithdrawalRequest$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("USER CRYPTO WITHDRAWAL ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> createTicket(Object obj, BuildContext context) async {
    final dio = Dio();
    HelpDeskTicketStruct ticket;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.createTicket(obj);
      print(jsonEncode(details));
      if (details.success) {
        print("TICKET DETAILS " + details.toString());
        ticket = HelpDeskTicketStruct.fromJson(details.result['message']);
        if (!ticket$.isClosed) {
          ticket$.add(ticket);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!ticket$.isClosed) {
          ticket$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!ticket$.isClosed) ticket$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("TICKET DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getAllTicket(BuildContext context) async {
    final dio = Dio();
    List<HelpDeskTicketStruct> ticket = [];
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getAllTickets();
      print(jsonEncode(details));
      if (details.success) {
        print("ALL TICKET DETAILS " + details.toString());
        ticket = (details.result['message'] as List)
            .map((entry) => HelpDeskTicketStruct.fromJson(entry))
            .toList();
        if (!ticket$.isClosed) {
          ticket$.add(ticket);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!ticket$.isClosed) {
          ticket$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!ticket$.isClosed) ticket$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("TICKET DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> createReply(Object obj, BuildContext context) async {
    final dio = Dio();
    ConversationsStruct reply;
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.replyTicket(obj);
      print(jsonEncode(details));
      if (details.success) {
        print("REPLY DETAILS " + details.toString());
        reply = ConversationsStruct.fromJson(details.result['message']);
        if (!reply$.isClosed) {
          reply$.add(reply);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!reply$.isClosed) {
          reply$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!reply$.isClosed) reply$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("REPLY DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> createReplyWithDocs(
      Map<String, dynamic> obj, BuildContext context) async {
    ConversationsStruct reply;
    final dio = Dio();
    bool flag = false;
    FormData formData = new FormData.fromMap(obj);
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['boundary'] = formData.boundary;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = obj['reply'] != null
          ? await client.replyTicketWithDoc(
              [obj['attachments']], obj['reply'], obj['id'], obj['user_id'])
          : await client.replyTicketWithDoc1(
              [obj['attachments']], obj['id'], obj['user_id']);
      print(jsonEncode(details));
      if (details.success) {
        reply = ConversationsStruct.fromJson(details.result['message']);
        print("REPLY DETAILS " + details.toString());
        if (!reply$.isClosed) {
          reply$.add(reply);
          flag = true;
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!reply$.isClosed) {
          reply$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!reply$.isClosed) reply$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("REPLY DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getAllConversations(int id, BuildContext context) async {
    final dio = Dio();
    List<ConversationsStruct> conversations = [];
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getAllConversations(id);
      print(jsonEncode(details));
      if (details.success) {
        print("CONVERSATIONS DETAILS " + details.toString());
        conversations = (details.result['message'] as List)
            .map((entry) => ConversationsStruct.fromJson(entry))
            .toList();
        if (!conversations$.isClosed) {
          conversations$.add(conversations);
          flag = true;
        }
      } else {
        print(details.result['error']);
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!conversations$.isClosed) {
          conversations$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!conversations$.isClosed) conversations$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("CONVERSATIONS DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> getUserNotification(BuildContext context) async {
    final dio = Dio();
    List<MobileNotificationsStruct> notify = [];
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getAllUserNotifications();
      print(jsonEncode(details));
      if (details.success) {
        print("USER NOTIFICATION DETAILS " + details.toString());
        notify = (details.result['message'] as List)
            .map((entry) => MobileNotificationsStruct.fromJson(entry))
            .toList();
        if (!notification$.isClosed) {
          notification$.add(notify);
          flag = true;
        }
      } else {
        print(details.result['error']);
        // showToast(details.result['error'],
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!notification$.isClosed) {
          notification$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!notification$.isClosed) notification$.add("");
      if (e is DioError) {
        // showToast(e.message.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("USER NOTIFICATION DETAILS ERROR " + e.toString());
      return false;
    }
  }

  Future<bool> updateMobile(BuildContext context, Object body) async {
    IUserStruct user;
    final dio = Dio();
    bool flag = false;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.updateUserMobile(body);
      if (kDebugMode) {
        print(jsonEncode(details));
      }
      if (details.success) {
        if (details.result['message'] is String) {
          showToast('Otp sent on Mail.',
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          flag = true;
        } else {
          user = IUserStruct.fromJson(details.result['message']);
          if (!updatePhone$.isClosed) {
            showToast('Successfully updated mobile number.',
                gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
            updatePhone$.add(user);
            flag = true;
          }
        }
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (!updatePhone$.isClosed) {
          updatePhone$.add("");
        }
      }
      return flag;
    } catch (e) {
      if (!updatePhone$.isClosed) updatePhone$.add("");
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return false;
    }
  }

  Future cancelUserOrder(Object body, BuildContext context) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.interceptors.add(TokenInterceptor(context: context));
    try {
      var orderData = await client.cancelOrder(body);
      print(jsonEncode(orderData));
      if (orderData.success) {
        OrderSchedulerStruct order =
            OrderSchedulerStruct.fromJson(orderData.result['message']);
        if (!cancelOrder$.isClosed) cancelOrder$.add(order);
      } else {
        if (!cancelOrder$.isClosed) cancelOrder$.add("");
        showToast(orderData.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!cancelOrder$.isClosed) cancelOrder$.add("");
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR ON GETTING BLOGS " + e.toString());
    }
  }

  Future getAllBanner(String limit, BuildContext context) async {
    final dio = Dio();
    List<BannerStruct> banners = [];
    final client = RestClient(dio);
    try {
      var bannerData = await client.getAllBanner(limit);
      print(jsonEncode(bannerData));
      if (bannerData.success) {
        banners = (bannerData.result['message'] as List)
            .map((entry) => BannerStruct.fromJson(entry))
            .toList();
        if (!banner$.isClosed) banner$.add(banners);
      } else {
        if (!banner$.isClosed) banner$.add("");
        // showToast(bannerData.result['error'],
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!banner$.isClosed) banner$.add("");
      if (e is DioError) {
        // showToast(e.error.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      // showToast(e.toString(),
      //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR GETTING BANNER " + e.toString());
    }
  }

  Future deleteUser(BuildContext context) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.interceptors.add(TokenInterceptor(context: context));
    try {
      var deleteAccount = await client.deleteAccount({});
      print(jsonEncode(deleteAccount));
      if (deleteAccount.success) {
        if (!deleteUser$.isClosed) {
          showToast(deleteAccount.result['message'],
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          deleteUser$.add(deleteAccount.result['message']);
        }
      } else {
        if (!deleteUser$.isClosed) deleteUser$.add("");
        showToast(deleteAccount.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!deleteUser$.isClosed) deleteUser$.add("");
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR DELETING USER " + e.toString());
    }
  }

  Future last24HourVolume(BuildContext context, String symbol) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      var volume = await client.getLast24HourVolume(symbol);
      if (volume.success) {
        if (!last24HourVolume$.isClosed) {
          last24HourVolume$.add(volume.result['message']);
        }
      } else {
        if (!last24HourVolume$.isClosed) last24HourVolume$.add("");
        showToast(volume.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!last24HourVolume$.isClosed) last24HourVolume$.add("");
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR WHILE GETTING 24 HOUR VOLUME " + e.toString());
    }
  }

  Future getAllAnnouncement(BuildContext context) async {
    final dio = Dio();
    List<AnnouncementStruct> announce = [];
    final client = RestClient(dio);
    try {
      var announceData = await client.getAnnouncements();
      print(jsonEncode(announceData));
      if (announceData.success) {
        announce = (announceData.result['message'] as List)
            .map((entry) => AnnouncementStruct.fromJson(entry))
            .toList();
        if (!announcement$.isClosed) announcement$.add(announce);
      } else {
        if (!announcement$.isClosed) announcement$.add("");
        // showToast(announceData.result['error'],
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!announcement$.isClosed) announcement$.add("");
      if (e is DioError) {
        // showToast(e.error.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      // showToast(e.toString(),
      //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR GETTING ANNOUNCEMENTS " + e.toString());
    }
  }

  Future getMasterCoins(BuildContext context, {String? symbol}) async {
    final dio = Dio();
    List<MasterCoinListingsStruct> entries = [];
    final client = RestClient(dio);
    dio.interceptors.add(TokenInterceptor(context: context));
    try {
      var data = symbol == null
          ? await client.getMasterCoinList()
          : await client.getMasterCoinList(symbol: symbol);
      print(jsonEncode(data));
      if (data.success) {
        entries = (data.result['message'] as List)
            .map((entry) => MasterCoinListingsStruct.fromJson(entry))
            .toList();
        if (!masterCoinList$.isClosed) masterCoinList$.add(entries);
      } else {
        if (!masterCoinList$.isClosed) masterCoinList$.add("");
        showToast(data.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!masterCoinList$.isClosed) masterCoinList$.add("");
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR GETTING MASTER COIN LIST " + e.toString());
    }
  }

  Future<bool> validateNetworkAddress(
      BuildContext context, String address, String type) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.interceptors.add(TokenInterceptor(context: context));
    try {
      var data = type == NetworkTypes.TRC20.name
          ? await client.validateTronAddress(address)
          : await client.validateBEP20AddressApiStruct(address);
      if (data.success) {
        return data.result['message'];
      } else {
        showToast(data.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR IN VALIDATING ADDRESS " + e.toString());
      return false;
    }
  }

  Future updateOpenNotification(Object obj, BuildContext context) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.interceptors.add(TokenInterceptor(context: context));
    try {
      var data = await client.updateNotification(obj);
      print(jsonEncode(data));
      if (data.success) {
        if (!notificationUpdate$.isClosed)
          notificationUpdate$.add(data.result['message']);
      } else {
        if (!notificationUpdate$.isClosed) notificationUpdate$.add("");
        showToast(data.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } catch (e) {
      if (!notificationUpdate$.isClosed) notificationUpdate$.add("");
      if (e is DioError) {
        showToast(e.error.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      print("ERROR IN OPEN NOTIFICATION " + e.toString());
    }
  }

  Future<UserDetailsStruct?> getDetailsOfUserDirect(
      BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.getUserDetails();
      if (details.success) {
        return UserDetailsStruct.fromJson(details.result['message']);
      }
      if (details.result['error'] != "No user Details Found") {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      if (details.result['error'] == "No user Details Found") {
        Com().commonAlertDialog(
            context,
            "Please fill all details in profile section in"
            " order to proceed.",
            btnText: "OK");
      }
      return null;
    } catch (e) {
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return null;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return null;
    }
  }

  Future<String> logOutAllUserDevices(BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.logOutAllDevices();
      showToast(
          details.success ? details.result['message'] : details.result['error'],
          gravity: ToastGravity.BOTTOM,
          toast: Toast.LENGTH_LONG);
      return details.success ? details.result['message'] : "";
    } catch (e) {
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return "";
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return "";
    }
  }

  Future<String> sendVerificationOtp(BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.sendActiveOtp();
      if (!details.success) {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      return details.success ? details.result['message'] : "";
    } catch (e) {
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return "";
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return "";
    }
  }

  Future<IUserStruct?> verifyVerificationOtp(
      BuildContext context, Object obj) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.verifyActiveOtp(obj);
      if (details.success) {
        return IUserStruct.fromJson(details.result['message']);
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      return null;
    } catch (e) {
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return null;
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return null;
    }
  }

  Future<String> changeUserPassword(BuildContext context, Object obj) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    try {
      var details = await client.changePassword(obj);
      showToast(
          details.success ? details.result['message'] : details.result['error'],
          gravity: ToastGravity.BOTTOM,
          toast: Toast.LENGTH_LONG);
      return details.success ? details.result['message'] : "";
    } catch (e) {
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return "";
      }
      showToast(e.toString(),
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return "";
    }
  }

  Future<UniqueCode?> getUniqueCode(
      BuildContext context, String? paymentMode) async {
    final dio = Dio();
    bool flag = false;

    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);

    try {
      // Fetching details
      var details = await client.getUniqueCode(paymentMode ?? '');
      print("The details fetched are: ${details}");

      // Checking if the response is successful
      if (details.success && details.result['message'] != null) {
        var response = details.result['message'];
        LoadingOverlay.hideLoader(context);
        if (!getUniquesCode$.isClosed) {
          getUniquesCode$.add(details);
          flag = true;
        }
        return UniqueCode.fromJson(details.result['message']);
      } else {
        if (!getUniquesCode$.isClosed) {
          getUniquesCode$.add("");
        }

        return null;
      }
    } catch (e) {
      // Error handling: Stream and flag updates
      if (!getUniquesCode$.isClosed) {
        getUniquesCode$.add("");
        flag = false;
      }

      // Dio-specific error handling
      if (e is DioError) {
        print("DioError occurred: ${e}");
        // showToast(e.message.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      } else {
        print("An unexpected error occurred: ${e}");
        // showToast(e.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }

      return null;
    } finally {
      // Hide loading overlay
      LoadingOverlay.hideLoader(context);
    }
  }

  Future<GenerateUniqueCodeStruct?> generateUniqueCode(
      BuildContext context, Object obj) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    bool flag = true;

    try {
      // Ensure obj is a Map before casting
      if (obj is Map<String, dynamic>) {
        final details = await client.generateUnique(obj);

        if (details.success) {
          getUniqueCode(context, obj['paymentMode']);
          if (!generateUniquesCode$.isClosed) {
            generateUniquesCode$.add(details);
          }
          showToast('${details.result['message']}',
              gravity: ToastGravity.BOTTOM,
              toast: Toast.LENGTH_LONG,
              isSuccess: true);
          return GenerateUniqueCodeStruct.fromJson(details.result['message']);
        } else {
          final errorMessage = details.result['error'];
          if (!generateUniquesCode$.isClosed) {
            generateUniquesCode$.add("");
            flag = false;
          }
          showToast('$errorMessage',
              gravity: ToastGravity.BOTTOM,
              toast: Toast.LENGTH_LONG,
              isSuccess: false);
          return null;
        }
      } else {
        // Handle the case where obj is not a Map
        throw ArgumentError('Expected a Map, but received ${obj.runtimeType}');
      }
    } catch (e) {
      // Hide the loader if an error occurs
      LoadingOverlay.hideLoader(context);

      if (e is DioError) {
        if (!generateUniquesCode$.isClosed) {
          generateUniquesCode$.add("");
          flag = false;
        }

        final errorMessage = e.response?.data?['message'] ?? e.message;
        print("The error message is ===>> $errorMessage");
        showToast(errorMessage.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      } else {
        if (!generateUniquesCode$.isClosed) {
          generateUniquesCode$.add("");
          flag = false;
        }

        // showToast(e.toString(),
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      return null;
    }
  }

  flush() {
    walletSubject$.close();
    userOrder$.close();
    orderBookSubject$.close();
    allCoinsSubject$.close();
    userDeposits$.close();
    coinTransactions$.close();
    userCompletedOrderEntries$.close();
    userPlacedOrderEntries$.close();
    ledgerEntries$.close();
    userDetails$.close();
    uploadDoc$.close();
    kycId$.close();
    userBank$.close();
    bankList$.close();
    iUser$.close();
    allMasterAuth$.close();
    otpResp$.close();
    dummyMasterAuth$.close();
    userLogs$.close();
    adminBanks$.close();
    inrRequest$.close();
    inrWithdrawalRequest$.close();
    userDepositAddress$.close();
    depositCrypto$.close();
    funds$.close();
    ticket$.close();
    reply$.close();
    conversations$.close();
    inrCoinSocket$.close();
    notification$.close();
    usdtCoinSocket$.close();
    updatePhone$.close();
    cancelOrder$.close();
    banner$.close();
    deleteUser$.close();
    last24HourVolume$.close();
    commonCoinSocket$.close();
    masterCoinList$.close();
    changeIndex$.close();
    generateUniquesCode$.close();
    getUniquesCode$.close();
  }
}

final apiCalls = new ApiCalls();
