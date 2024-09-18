import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/profile/allTickets.dart';
import 'package:cryptox/pages/profile/createTicket.dart';
import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  @override
  _Support createState() => _Support();
}

class _Support extends State<Support> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'Support',
          style: white16SemiBoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: primaryColor,
                controller: tabController,
                tabs: [
                  Tab(text: "Create Ticket"),
                  Tab(text: "All Tickets"),
                ]
            ),
            Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    CreateTicket(),
                    AllTickets()
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

}