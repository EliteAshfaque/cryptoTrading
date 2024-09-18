


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/ConstantString.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import '../../widgets/DataNotFoundView.dart';
import '../../widgets/ShimmerLoaderView.dart';
import 'BankController.dart';


class BankPage extends StatelessWidget {
  BankController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBarView(
        titleText: "Bank",
        isImageTitle: false,
        bodyWidget: Obx(() => Column(
          children: [

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: TextFormField(
                  controller: controller.searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.searchBankList.value =  controller.bankList
                          .where((element) => ((element.bankName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                          (element.ifsc ?? "").toLowerCase().contains(value.toLowerCase())))
                          .toList();
                    } else {
                      controller.searchBankList.value =  controller.bankList;
                    }

                  },
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Icon(Icons.search,color: Colors.grey[500],),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        controller.searchController.text = "";
                        controller.searchBankList.value =  controller.bankList;
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    hintText: "Search",
                    hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  )),
            ),
            if(controller.isApiLoadComplete.value==true && controller.searchBankList.isNotEmpty)
            Expanded(child: ListView.builder(
              itemCount: controller.searchBankList.length,
              itemBuilder: (context, index) {
                var item=controller.searchBankList[index];
                return InkWell(
                  onTap: () => Get.back(result: item),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipOval(
                          child: CachePlaceHolderImage(imageUrl: "$BASE_BANK_LOGO_URL${item.id}.png",
                              imageHeight: 50,
                              imgaeWidth: 50,
                              isCached: true,
                              errorContainerHeight: 50,
                              errorContainerWidth: 50,
                              errorIconHeight: 40,
                              errorColorBackground: gray_1,
                              errorColorIcon: gray_3),
                        ),
                        widthSpace_15,
                        Expanded(child: Text(item.bankName??"",style: poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14))),
                        widthSpace_10,
                        const Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black),
                      ],
                    ),
                  ),
                );
              },))
            else if(controller.isApiLoadComplete.value==false && controller.searchBankList.isEmpty)
              Expanded(
                child: ShimmerLoaderView(widget: ListView(
                  children: List.generate(12, (index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(width: 50,height: 50,decoration: const BoxDecoration(
                            color: primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        )),
                        widthSpace_15,
                        Expanded(child: Container(color: primaryColorLight,height: 40)),
                        widthSpace_10,
                        const Icon(Icons.arrow_forward_ios,size: 16,color: primaryColorLight),
                      ],
                    ),
                  )),
                ),),
              )
            else  const Expanded(child: DataNotFoundView(text: "Bank is not available",))
          ],
        ))
      )
    );
  }

}
