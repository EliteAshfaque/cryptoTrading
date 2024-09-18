import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinAppDrawerCard extends StatelessWidget {

  CoinListings item;
  FiatType fiatType;
  CoinAppDrawerCard({required this.item, required this.fiatType});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 1.0,
            color: blackColor.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Com.tokenImage(imageUrl: item.imgUrl!,height: 40, width: 40),
              Container(
                  margin: EdgeInsets.only(left: 12.0),
                  child: Text(
                      item.symbol!.replaceFirst(fiatType.name, "") +
                          "/" +
                          fiatType.name,
                      style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600)))
            ],
          ),
          Column(
            children: [
              Text((fiatType == FiatType.INR ? "₹" : "\$") + item.closePrice!.toStringAsFixed(6),
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500)),
              Row(
                children: [
                  (item.ticker == 'up')
                      ? Icon(
                    Icons.arrow_drop_up,
                    color: greenColor,
                  )
                      : Icon(Icons.arrow_drop_down,
                      color: redColor),
                  Text(
                    item.percentageChange!,
                    style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

}