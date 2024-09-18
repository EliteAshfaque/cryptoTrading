import 'package:cryptox/pages/profile/about_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/constant.dart';
import '../constant/image_const.dart';

class CDMPrivacyPolicy extends StatefulWidget {
  const CDMPrivacyPolicy({super.key});

  @override
  State<CDMPrivacyPolicy> createState() => _CDMPrivacyPolicyState();
}

class _CDMPrivacyPolicyState extends State<CDMPrivacyPolicy> {
  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          titleSpacing: 0.0,
          title: Text(
            'CDM  Terms and Condition',
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
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Deposit Mechanism',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    // Aligns text to the center
                    " Deposits may exclusively be executed in Indian Rupees (INR) through a Cash Deposit Machine (CDM) or at a bank's teller counter. Transactions processed via UPI, NEFT, RTGS, or IMPS will not be recognized or credited to the user's account",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    '2. Unclaimed Balances',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.left,
                        // Aligns text to the center
                        " Any unclaimed or unutilized amounts will be considered the user's loss. The platform is not responsible for such losses",

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        // Aligns text to the center
                        "In case of any un-exploited amount provided, it is the loss of customer only; the platform is not responsible for that.",

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        // Aligns text to the center
                        "In case of any discrepancy found, the account will be forbidden",

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    '3. Proof of Deposit',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.left, // Aligns text to the center

                        ' • At OneFX, our mission is to democratize access to financial services by providing a reliable and secure platform for cryptocurrency trading. We aim to empower individuals and businesses worldwide to participate in the digital economy.',
                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        // Aligns text to the center

                        " • Should deposit slips be ambiguous or entries erroneous, the transaction will be classified as disputed.",
                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        // Aligns text to the center

                        " •  Although the platform does not guarantee a fixed resolution period, it will make a concerted effort to resolve disputes within a timeframe of 2-3 business days.",
                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    '4 Deposits via Cash Deposit Machine (CDM)',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.left, // Aligns text to the center
                        "Users are required to upload the deposit slip and accurately enter the UTR number or transaction ID.",

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        " In the event of multiple UTR deposits, the account may be suspended or the transaction case may be deemed invalid.",
                        // Aligns text to the center

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        "Once the transaction is submitted, it is expected to be reflected in the user’s account within approximately 15 minutes.",
                        // Aligns text to the center

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        "For requests to trade additional cryptocurrencies, users should submit a request through our community channels. The support team will review and consider these requests accordingly.",
                        // Aligns text to the center

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '5. Deposits via Bank Window',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.left, // Aligns text to the center
                        "Users are obligated to upload the deposit slip issued by the banking institution",

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        "The platform may require up to 5 to 6 hours for deposit processing, subject to the timing of updates from the banking entity.",
                        // Aligns text to the center

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        "Upon the successful reconciliation of the deposit, users will be credited with USDT in their wallet. This USDT can be utilized for trading any cryptocurrency available on the platform.",
                        // Aligns text to the center

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        "To initiate trading of additional cryptocurrencies, users must submit a formal request through our designated community channels. The support team will undertake a comprehensive review and deliberation of these requests.",

                        // Aligns text to the center

                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
