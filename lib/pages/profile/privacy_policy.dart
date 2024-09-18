import 'package:cryptox/constant/constant.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'Privacy Policy',
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          height20Space,
          privacyPolicy(),
          height20Space,
          scopeOfApplication(),
          height20Space,
          useOfApplication(),
          height20Space,
          disclosureOfApplication(),
          height20Space,
          storageOfInformation(),
          height20Space,
          protectionOfInformation(),
          height20Space,
          disclaimerOfLiability(),
          height20Space,
          externalWebsites(),
          height20Space,
          statutoryRights(),
          height20Space,
          contactUs(),
          height20Space,
        ],
      ),
    );
  }

  privacyPolicy() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Privacy Policy',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "Grasper Utility & Technology Pvt Ltd will protect all personal information you submit to us when using our products and services. We may use or disclose your personal information in compliance with this Privacy Policy to provide better services to you. By using our products and services, you consent to the practices contained in this Privacy Policy. We may amend this Privacy Policy from time to time and strongly encourage you to review it whenever you access or use Grasper Utility & Technology Pvt Ltd services to stay informed about our information practices and your privacy rights and choices. If you ever have any questions about changes made to the Privacy Policy, please reach out to support@1fx.com.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  scopeOfApplication() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. Scope of Application',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "This Privacy Policy applies to:\n\n A）your personal information including your name, email address, date of birth, tax number (if applicable), username, password or other personal information when you open an account on our Platforms;\n\n"
                "B）your browsing history and/or information related to your device, including and not limited to the types of device (Computer vs. iPhone vs. Android), operating system, mobile phone number, browser type and language, device identifiers (such as IMEI and MAC address), Internet Protocol (IP) address, location information, cookies identifiers, Internet service provider, etc.;\n\n "
                "C）your personal information we obtain from other sources, including third-party business partners through which you access our Platforms and related services. \n\n"
                "You understand and agree that this Privacy Policy is not applicable to the following information:\n\n "
                "A）Your search keywords when using our Platforms; \n\n "
                "B）Public content you create on our Platforms, including but not limited to forum posts, blogs, or social media pages; \n\n "
                "C）Your violation of laws, regulations or our Platforms’ rules and publishing measures you are subject to.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  useOfApplication() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2. Use of Information',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "We use your information for various business purposes, including but not limited to: \n\n "
                "A）to provide you with information about products and promotions that may be of interest to you, from ourselves and third parties, although only if you have specifically agreed to receive such information;\n\n"
                "B）to process applications or transactions you made and your financial information for products or services you purchased on our Platforms and; \n\n"
                "C）to enhance your information security by detecting malicious, deceptive, fraudulent or illegal activities; \n\n"
                "D）to improve our services by researching and developing our products and services;\n\n"
                "E）to comply with domestic and international legal obligations.\n\n"
                "We will gather and take good care of your personal information. If we need to share with third-party business partners to provide better service experience for you, we will require partners to protect your information as stated in this Privacy Policy.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  disclosureOfApplication() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3. Disclosure of Information',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "We may disclose any personal information we collect about you: \n\n"
                "A）to non-affiliated third parties at your consent;\n\n"
                "B）to third party service/product providers so that you can use their service/product;\n\n"
                "C）to our business partners when we co-launch a product or service;\n\n"
                "D）to our affiliated entites;\n\n"
                "E）to other sites when deemed necessary by law, regulations or Privacy Policy.\n\n"
                "F）when disclosure is necessary to report suspected illegal activity;\n\n"
                "G）when disclosure is necessary to investigate violations of laws, regulations or this Privacy Policy;\n\n"
                "H）when compelled by subpoena, court order, or other legal procedure;",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  storageOfInformation() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4. Storage/Transfer of Information',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "You acknowledge that we store and process your personal and transactional information in multiple locations in the world where our service providers are located, and we protect it by maintaining physical, electronic, and procedural safeguards in compliance with applicable regulations.\n\n"
                "Your personal information we receive will be stored for as long as you use our services or as necessary to fulfill the purpose(s) for which it was collected, provide our services, resolve disputes, establish legal defenses, conduct audits, pursue legitimate business purposes, enforce our measures, and comply with applicable laws.\n\n"
                "You also acknowledge that when a merger, acquisition, financing due diligence, reorganization, bankruptcy, receivership, purchase or sale of assets, or transition of service to another provider occurs, your information may be sold or transferred as part of such a transaction, as permitted by law and/or contract.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  protectionOfInformation() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5. Protection of Information',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "A）We implement reasonable security practices and procedures to protect the confidentiality and security of your information, including any nonpublic personal information.\n\n"
                "B）We protect your information using reasonable physical, technical and administrative security measures such as limitation of access on employees to your information.\n\n"
                "C）You are responsible for reviewing the privacy statements, policies, terms, and conditions of any person or company to whom you choose to link or with whom you choose to contract.\n\n"
                "D）We cannot guarantee or warrant the security of any information you provide to us as no system is perfectly secure.\n\n"
                "E）If you find your personal information (especially username and passwords on our Platforms) disclosed, you should immediately contact our support for protection measures.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  disclaimerOfLiability() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '6. Disclaimer of Liability',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "Grasper Utility & Technology Pvt Ltd assumes no liability or responsibility, to the fullest extent of any applicable law, for: \n\n"
                "A）any unintentional disclosure; \n\n"
                "B）disclosure of your personal information because you share with others your account(s) or password(s) on our Platforms;\n\n"
                "C）any stolen, lost, or unauthorized use of your account information any breach of security or data terms related to your account information, or any criminal or other third party act affecting our Platforms;\n\n"
                "D）lawsuits or related damages led by disclosure of your personal information on our external websites.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  externalWebsites() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7. External Websites',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "Occasionally, the Grasper Utility & Technology Pvt Ltd website may provide references or links to other websites ('External Websites'). We do not control these External Websites or any of the content contained therein. External Websites have separate and independent terms of use and related policies. \n\n"
            "We request that you review the policies, rules, terms, and regulations of each site that you visit. If you prefer not to share your personal information with External Websites, please note that you must separately opt out of their use of your information for various purposes.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }


  statutoryRights() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '8. Your Statutory Rights',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "Depending on applicable law, you may have the rights as set out below, which you may exercise by contacting us at support@1fx.com.\n\n"
                "A）Access: you are entitled to ask us if we are processing your information and, if we are, you can request access to your personal data. This enables you to receive a copy of the personal data we hold about you and certain other information about it to check that we are lawfully processing it. We process a large quantity of information, and can thus request that before the information is delivered, you specify the information or processing activities to which your request relates.\n\n"
                "B）Correction: you are entitled to request that any incomplete or inaccurate personal data we hold about you is corrected.\n\n"
                "C）Erasure: you are entitled to ask us to delete or remove personal data in certain circumstances. There are also certain exceptions where we may refuse a request for erasure, for example, where the personal data is required for compliance with law or in connection with claims.\n\n"
                "D）Restriction: you are entitled to ask us to suspend the processing of certain of your personal data about you, for example if you want us to establish its accuracy or the reason for processing it.\n\n"
                "E）Transfer: you may request the transfer of certain of your personal data to another party.\n\n"
                "F）Objection: where we are processing your personal data based on legitimate interests (or those of a third party) you may challenge this. However, we may be entitled to continue processing your information based on our legitimate interests or where this is relevant to legal claims. You also have the right to object where we are processing your personal data for direct marketing purposes.\n\n"
                "If these rights apply, they may however be limited, for example if fulfilling your request would reveal personal data about another person, would infringe the rights of another person or legal entity (including our rights), or if you ask us to delete or change data which we are required by law to keep (or have other compelling legitimate interests in keeping). We will inform you of relevant exemptions we rely upon when responding to any request you make.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  contactUs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '9. Contact Us',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            "If you have any questions relating to our privacy policy and your rights and obligations arising from these policy terms, or if you intend to exercise your rights stated in this privacy policy, please contact support@1fx.com.",
            style: black14RegularTextStyle,
          ),
        ],
      ),
    );
  }


}
