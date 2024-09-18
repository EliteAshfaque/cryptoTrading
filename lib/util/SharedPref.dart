import 'dart:convert';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KeyNotFound = "KeyNotFound";

const String _ClickOnVerified = "ClickOnVerified";
const String _email = "email";
const String _name = "name";
const String _token = "token";
const String _phone = "phone";
const String _countryCode = "countryCode";
const String _isAdmin = "isAdmin";
const String _mobileTokenKey = "mobileToken";
const String _userSavedCoinList = "userSavedCoinList";
const String _sessionId = "sessionId";
const String _userVerified = "userVerified";
const String _isDeleteApproval = "isDeleteApproval";
const String _UserId = "UserId";
const String _FormFilledStatus = "FormFilledStatus";

Future<SharedPreferences> initialiseSharedPref() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<String?> getClickOnVerified() async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(_ClickOnVerified)) {
    String? val = prefs.getString(_ClickOnVerified);
    return val;
  } else {
    return KeyNotFound;
  }
}

Future<void> addStringToSF({email, name, countryCode,phone, token, admin, sessionId, isDeleteApproval,
  userVerified}) async{
  SharedPreferences prefs = await initialiseSharedPref();
  prefs.setString(_email, email);
  prefs.setString(_name, name);
  prefs.setInt(_countryCode, countryCode);
  prefs.setString(_phone, phone);
  prefs.setString(_token, token);
  prefs.setBool(_isAdmin, admin);
  prefs.setBool(_isDeleteApproval, isDeleteApproval);
  prefs.setString(_sessionId, sessionId);
  prefs.setBool(_userVerified, userVerified);
}


Future<bool> checkLoggedIn() async {
  SharedPreferences prefs = await initialiseSharedPref();
  return (prefs.containsKey(_email) && prefs.containsKey(_name) &&
      prefs.containsKey(_phone) && prefs.containsKey(_token) &&
      prefs.containsKey(_isAdmin));
}

Future<Map<String,dynamic>> getUserDetailsFromSF() async {
  Map<String,dynamic> map = new Map();
  SharedPreferences prefs = await initialiseSharedPref();
  if(prefs.containsKey(_email)) {
    map.putIfAbsent(_email, () => prefs.getString(_email) ?? "");
  }
  if(prefs.containsKey(_name)) {
    map.putIfAbsent(_name, () => prefs.getString(_name) ?? "");
  }
  if(prefs.containsKey(_countryCode)) {
    map.putIfAbsent(_countryCode, () => prefs.getInt(_countryCode) ?? 91);
  }
  if(prefs.containsKey(_phone)) {
    map.putIfAbsent(_phone, () => prefs.getString(_phone) ?? "");
  }
  if(prefs.containsKey(_token)) {
    map.putIfAbsent(_token, () => prefs.getString(_token) ?? "");
  }
  if(prefs.containsKey(_isAdmin)) {
    map.putIfAbsent(_isAdmin, () => prefs.getBool(_isAdmin) ?? false);
  }
  return map;
}

Future<String> getUserToken() async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(_token)) {
    return prefs.getString(_token)!;
  } else {
    return KeyNotFound;
  }
}

Future<String> getUserName() async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(_name)) {
    return prefs.getString(_name)!;
  } else {
    return KeyNotFound;
  }
}


Future<String> getUserMobileToken() async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(_mobileTokenKey)) {
    return prefs.getString(_mobileTokenKey)!;
  } else {
    return KeyNotFound;
  }
}

Future<dynamic> getValueForKey(String key) async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(key)) {
    return prefs.getString(key)!;
  } else {
    return KeyNotFound;
  }
}

Future<bool> getValueForKeyBool(String key) async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(key)) {
    return prefs.getBool(key)!;
  } else {
    return false;
  }
}

Future<String> getUserEmail() async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(_email)) {
    return prefs.getString(_email)!;
  } else {
    return KeyNotFound;
  }
}


Future<int> alterUserCoinList(CoinListings selectedCoin) async{
  SharedPreferences prefs = await initialiseSharedPref();
  try {
    if (prefs.containsKey(_userSavedCoinList)) {
      List<String> arr = [];
      var savedCoins = prefs.getStringList(_userSavedCoinList)!;
      if (kDebugMode) {print("SAVED COIN LIST "+savedCoins.toString());}
      List<CoinListings> coins = (savedCoins)
          .map((coin) => CoinListings.fromJson(jsonDecode(coin)))
          .toList();
      int index = coins.indexWhere((element) => element.symbol == selectedCoin.symbol);
      if(index == -1) {
        print("ADDING ELEMENT");
        coins.add(selectedCoin);
        coins.forEach((element) {
          arr.add(jsonEncode(element));
        });
        await prefs.setStringList(_userSavedCoinList, arr);
        if (kDebugMode) {print("LIST AFTER ADDING ELEMENT "+arr.toString());}
        return 1;
      }else {
        coins.removeAt(index);
        if(coins.length == 0) {
          await prefs.remove(_userSavedCoinList);
          return 2;
        }
        coins.forEach((element) {
          arr.add(jsonEncode(element));
        });
        await prefs.setStringList(_userSavedCoinList, arr);
        if (kDebugMode) {print("LIST AFTER REMOVING ELEMENT "+arr.toString());}
        return 2;
      }
    } else {
      List<String> arr = [];
      List<CoinListings> coins = [];
      coins.add(selectedCoin);
      coins.forEach((element) {
        arr.add(jsonEncode(element));
      });
      //print(arr.toString());
      await prefs.setStringList(_userSavedCoinList, arr);
      if (kDebugMode) {print("LIST AFTER ADDING ELEMENT 1 "+arr.toString());}
      return 1;
    }
  } catch(e) {
    print("ERROR WHILE SAVING COIN "+e.toString());
    return 3;
  }
}

Future<bool> updateCoinLocally(CoinListings val) async {
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(_userSavedCoinList)) {
    List<String> arr = [];
    var savedCoins = prefs.getStringList(_userSavedCoinList)!;
    List<CoinListings> coins = (savedCoins)
        .map((coin) => CoinListings.fromJson(jsonDecode(coin)))
        .toList();
    int index = coins.indexWhere((element) => element.symbol == val.symbol);
    if(index != -1) {
      print("ADDING ELEMENT");
      coins[index] = val;
      coins.forEach((element) {
        arr.add(jsonEncode(element));
      });
      await prefs.setStringList(_userSavedCoinList, arr);
      return true;
    }
  }
  return false;
}

Future<List<CoinListings>> getUserSavedList() async {
  SharedPreferences prefs = await initialiseSharedPref();
  try {
    var savedCoins = prefs.getStringList(_userSavedCoinList)!;
    if (kDebugMode) {print(savedCoins.toString());}
    List<CoinListings> coins = (savedCoins)
        .map((coin) => CoinListings.fromJson(jsonDecode(coin)))
        .toList();
    return coins;
  } catch(e) {
    print("ERROR WHILE GETTING USER SAVED LIST "+e.toString());
    return [];
  }
}

Future<void> setValueForKey(String key,String value) async{
  SharedPreferences prefs = await initialiseSharedPref();
  //if(prefs.containsKey(key)) {
  prefs.setString(key, value);
  //}
}

Future<void> setValueForBoolKey(String key,bool value) async{
  SharedPreferences prefs = await initialiseSharedPref();
  prefs.setBool(key, value);
}

Future<void> cleanSharedPrefsKey(String key) async{
  SharedPreferences prefs = await initialiseSharedPref();
  if (prefs.containsKey(key)){
    await prefs.remove(key);
  }
}


Future<bool> cleanSharedPrefs() async{
  try {
    SharedPreferences prefs = await initialiseSharedPref();
    for(String key in prefs.getKeys()) {
      if(key != _userSavedCoinList) {
        prefs.remove(key);
      }
    }
    return true;
  } catch(e) {
    return false;
  }
}
