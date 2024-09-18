import 'package:cryptox/constant/api.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/constant/image_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyWeb createState() => _PrivacyPolicyWeb();
}

class _PrivacyPolicyWeb extends State<AboutUs> {
  WebViewController controllerWebView =
      WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams());

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
            'About Us',
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
                    'About OneFx',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    textAlign: TextAlign.left, // Aligns text to the center

                    'ONEFX, is an advanced cryptocurrency trading platform that combines innovation, efficiency, and security to offer users a comprehensive and seamless trading experience. With its user-friendly interface, leveraged trading system, robust security measures, exceptional customer support, and extensive market coverage, ONEFX is poised to become a go-to platform for traders looking to capitalize on the vast potential of cryptocurrencies. Whether you are a seasoned trader or just starting your crypto journey, ONEFX provides the tools and resources to help you thrive in this exciting and rapidly growing market.',
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
                    'Our Services',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    textAlign: TextAlign.left, // Aligns text to the center

                    'As the cryptocurrency landscape evolves rapidly, ONEFX remains at the forefront, providing cutting-edge solutions and comprehensive resources to meet the diverse needs of our users. Whether you are a seasoned trader, a blockchain enthusiast, or someone exploring the world of digital assets for the first time, ONEFX is your go-to destination for reliable information, innovative tools, and seamless transactions.',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14, height: 1.5),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    'Our Mission',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    textAlign: TextAlign.left, // Aligns text to the center

                    'At OneFX, our mission is to democratize access to financial services by providing a reliable and secure platform for cryptocurrency trading. We aim to empower individuals and businesses worldwide to participate in the digital economy.',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14, height: 1.5),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    'Our Commitment',
                    style: white18BoldTextStyle,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  content(
                      "We believe in transparency and integrity. That's why we strive to provide accurate, up-to-date information about cryptocurrencies, blockchain projects, and market trends, empowering our users to make informed decisions.",
                      'Transparency',
                      blue),
                  SizedBox(
                    height: 14,
                  ),
                  content(
                      'Security is our top priority. We employ advanced encryption technologies and adhere to industry best practices to safeguard your assets and personal information. With ONEFX, you can trade with confidence, knowing that your funds are protected.',
                      'Security',
                      green),
                  SizedBox(
                    height: 14,
                  ),
                  content(
                      "Innovation drives everything we do. From user-friendly trading platforms to advanced analytics tools, we're continuously innovating to enhance your trading experience and unlock new opportunities in the crypto space.",
                      'Innovation',
                      goldenYellow),
                  SizedBox(
                    height: 14,
                  ),
                  content(
                      "We're more than just a platform - we're a community. Join thousands of like-minded individuals and connect with fellow crypto enthusiasts, share insights, and stay informed about the latest developments in the blockchain ecosystem.",
                      "Community",
                      brickRed),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.justify, // Aligns text to the center

                      'Navigate the Crypto Universe with Confidence.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                'https://x.com/i/flow/login?redirect_after_login=%2FONEFX_TRADING');
                          },
                          child: SvgPicture.asset(ImageConst.xSvg,
                              height: 22, fit: BoxFit.fitWidth),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                'https://www.facebook.com/onefxcryptotrading/');
                          },
                          child: SvgPicture.asset(ImageConst.facebookSvg,
                              height: 22, fit: BoxFit.fitWidth),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                'https://www.instagram.com/onefx_trading/');
                          },
                          child: SvgPicture.asset(ImageConst.instagramSvg,
                              height: 22, fit: BoxFit.fitWidth),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                'https://www.pinterest.com/onefx_trading/');
                          },
                          child: SvgPicture.asset(ImageConst.ptSvg,
                              height: 22, fit: BoxFit.fitWidth),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                'https://www.youtube.com/channel/UC2vAt6A_MInAbWtdOiHG78Q');
                          },
                          child: SvgPicture.asset(ImageConst.youTubeSvg,
                              height: 22, fit: BoxFit.fitWidth),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl('https://t.me/onefxchange');
                          },
                          child: SvgPicture.asset(ImageConst.tgSvg,
                              height: 22, fit: BoxFit.fitWidth),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Widget content(String? contentText, String? heading, Color? color) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5),
    child: Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
            child: Text(
              '${heading}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              textAlign: TextAlign.left, // Aligns text to the center

              '${contentText}',
              style: TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    ),
  );
}
