import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/account/orderEntries/completeOrderEntries.dart';
import 'package:cryptox/pages/account/orderEntries/placedOrderEntries.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';

import 'cancel_order_entries.dart';

class OrderEntries extends StatefulWidget {
  @override
  _OrderEntries createState() => _OrderEntries();
}

class _OrderEntries extends State<OrderEntries>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: Com.barGradient(),
        )),
        title: Text(
          'Orders',
          style: white16SemiBoldTextStyle,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.search,
        //       color: primaryColor,
        //     ),
        //   ),
        // ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(indicatorColor: primaryColor, tabs: [
              Tab(text: "Placed"),
              Tab(text: "Cancelled"),
              Tab(text: "Completed"),
            ]),
            Expanded(
                child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                PlacedOrderEntries(),
                CancelOrderEntries(),
                CompleteOrderEntries(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
