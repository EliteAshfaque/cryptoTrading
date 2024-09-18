
import 'package:cryptox/constant/constant.dart';
import 'package:flutter/material.dart';


class TopGainer extends StatefulWidget {
  const TopGainer({Key? key}) : super(key: key);

  @override
  _TopGainerState createState() => _TopGainerState();
}

class _TopGainerState extends State<TopGainer> {
  final topGainerList = [
    {
      'name': 'XRP',
      'shortName': 'XRP',
      'image': 'assets/crypto_icon/xrp.png',
      'value': '\$0.262855',
      'status': 'up',
      'change': '8.95%'
    },
    {
      'name': 'Litecoin',
      'shortName': 'LTC',
      'image': 'assets/crypto_icon/ltc.png',
      'value': '\$71.24',
      'status': 'up',
      'change': '7.12%'
    },
    {
      'name': 'Bitcoin',
      'shortName': 'BTC',
      'image': 'assets/crypto_icon/btc.png',
      'value': '\$10,136.73',
      'status': 'up',
      'change': '6.72%'
    },
    {
      'name': 'Ethereum',
      'shortName': 'ETH',
      'image': 'assets/crypto_icon/eth.png',
      'value': '\$185.65',
      'status': 'up',
      'change': '6.23%'
    },
    {
      'name': 'Bitcoin Cash',
      'shortName': 'BCH',
      'image': 'assets/crypto_icon/bch.png',
      'value': '\$297.98',
      'status': 'up',
      'change': '4.55%'
    },
    {
      'name': 'Binance Coin',
      'shortName': 'BNB',
      'image': 'assets/crypto_icon/bnb.png',
      'value': '\$27.11',
      'status': 'up',
      'change': '3.43%'
    },
    {
      'name': 'EOS',
      'shortName': 'EOS',
      'image': 'assets/crypto_icon/eos.png',
      'value': '\$3.44',
      'status': 'up',
      'change': '3.12%'
    },
    {
      'name': 'Monero',
      'shortName': 'XMR',
      'image': 'assets/crypto_icon/xmr.png',
      'value': '\$1.54',
      'status': 'up',
      'change': '2.75%'
    },
    {
      'name': 'Tether',
      'shortName': 'USDT',
      'image': 'assets/crypto_icon/usdt.png',
      'value': '\$1.23',
      'status': 'up',
      'change': '1.58%'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: topGainerList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = topGainerList[index];
        return Padding(
          padding: (index != topGainerList.length - 1)
              ? EdgeInsets.fromLTRB(
                  fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0)
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
        );
      },
    );
  }
}
