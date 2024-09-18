import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<AccountActionsModel> accountItem = [
    AccountActionsModel(
        name: 'Deposit Entries',
        icon: Icons.account_balance_wallet,
        route: '/deposit'),
    AccountActionsModel(
        name: 'Withdrawal Entries',
        icon: Icons.account_balance_wallet,
        route: '/withdrawal'),
    AccountActionsModel(
        name: 'Orders', icon: Icons.add_business, route: '/order'),
    AccountActionsModel(
        name: 'All Transactions', icon: Icons.ac_unit, route: '/ledger'),
    AccountActionsModel(
        name: 'Crypto Action',
        icon: Icons.currency_bitcoin,
        route: '/crypto_action'),
    AccountActionsModel(
        name: 'Bank Deposit',
        icon: FontAwesomeIcons.bank,
        route: '/bank_deposit'),
    AccountActionsModel(
        name: 'CDM Entries',
        icon: FontAwesomeIcons.wallet,
        route: '/cdm_history'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          title: Text(
            'Account',
            style: black16SemiBoldTextStyle,
          ),
          elevation: 0.0,
        ),
        body: GridView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(5.5),
            itemCount: accountItem.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0,
            ),
            itemBuilder: (context, i) {
              AccountActionsModel item = accountItem[i];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, item.route);
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(6, fixPadding, 6, fixPadding),
                    margin: EdgeInsets.all(5.5),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 30.0, color: primaryColor2),
                        heightSpace,
                        Text(item.name,
                            textAlign: TextAlign.center,
                            style: black14MediumTextStyle)
                      ],
                    )),
              );
            }));
  }
}
