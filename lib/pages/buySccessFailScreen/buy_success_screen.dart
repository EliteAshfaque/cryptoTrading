import 'package:cryptox/api/Order/placeOrder/placeOrder.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:flutter/material.dart';

class BuySuccessScreen extends StatelessWidget {
  final PlaceOrderStruct placedOrder;
  const BuySuccessScreen({Key? key, required this.placedOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: scaffoldBgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height20Space,
                height20Space,
                height20Space,
                Text(
                  'Congratulations!',
                  style: black10w600TextStyle,
                ),
              ],
            ),
            Container(
              width: 140.0,
              height: 140.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70.0),
                color: greenColor.withOpacity(0.3),
              ),
              child: Container(
                width: 110.0,
                height: 110.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  color: placedOrder.type == OrderTypes.BUY.name ? greenColor : redColor,
                ),
                child: Icon(
                  Icons.check,
                  size: 50.0,
                  color: whiteColor,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width - fixPadding * 4.0,
                  child: Text(
                    'You have successfully ${placedOrder.type!.toLowerCase()} ${placedOrder.totalQty!.toString()} '
                        '${placedOrder.symbol!.replaceFirst("INR", "")}.',
                    style: grey14MediumTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                height20Space,
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.topToBottom,
                      //     child: BuyFailScreen(),
                      //   ),
                      // );
                    },
                    borderRadius: BorderRadius.circular(7.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(fixPadding * 1.7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: placedOrder.type == OrderTypes.BUY.name ? greenColor : redColor,
                      ),
                      child: Text(
                        'Okay!',
                        style: white16MediumTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
