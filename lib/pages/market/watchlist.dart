import 'package:cryptox/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  final watchListItem = [
    {
      'name': 'Ethereum',
      'shortName': 'ETH',
      'image': 'assets/crypto_icon/eth.png',
      'value': '\$185.65',
      'status': 'up',
      'change': '6.86%'
    },
    {
      'name': 'XRP',
      'shortName': 'XRP',
      'image': 'assets/crypto_icon/xrp.png',
      'value': '\$0.262855',
      'status': 'down',
      'change': '8.95%'
    },
    {
      'name': 'Bitcoin Cash',
      'shortName': 'BCH',
      'image': 'assets/crypto_icon/bch.png',
      'value': '\$297.98',
      'status': 'up',
      'change': '4.55%'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return (watchListItem.isEmpty)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: greyColor.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.remove_red_eye,
                  color: greyColor,
                  size: 55.0,
                ),
              ),
              heightSpace,
              heightSpace,
              Text(
                'Watchlist is empty!',
                style: grey20BoldTextStyle,
              ),
            ],
          )
        : ListView.builder(
            itemCount: watchListItem.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = watchListItem[index];
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  Padding(
                    padding: (index != watchListItem.length - 1)
                        ? EdgeInsets.only(top: fixPadding * 2.0)
                        : EdgeInsets.symmetric(vertical: fixPadding * 2.0),
                    child: IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        setState(() {
                          watchListItem.removeAt(index);
                        });

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Removed from watchlist'),
                        ));
                      },
                    ),
                  ),
                ],
                child: Padding(
                  padding: (index != watchListItem.length - 1)
                      ? EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 2.0,
                          fixPadding * 2.0, 0.0)
                      : EdgeInsets.all(fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.size,
                      //         alignment: Alignment.center,
                      //         child: CoinView(coin: {} as CoinListings)));
                    },
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: EdgeInsets.all(fixPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: blackColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            item['image']!,
                            height: 50.0,
                            width: 50.0,
                            fit: BoxFit.cover,
                          ),
                          widthSpace,
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name']!,
                                      style: black14MediumTextStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          item['shortName']!,
                                          style: black12RegularTextStyle,
                                        ),
                                        widthSpace,
                                        (item['status'] == 'up')
                                            ? Icon(
                                                Icons.arrow_drop_up,
                                                color: primaryColor,
                                              )
                                            : Icon(
                                                Icons.arrow_drop_down,
                                                color: redColor,
                                              ),
                                        Text(
                                          item['change']!,
                                          style: black12RegularTextStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  item['value']!,
                                  style: black16MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
