import 'dart:async';

import 'package:flutter/material.dart';

import '../api/model/banner/Banners.dart';
import '../themes/ThemeColor.dart';
import 'CachePlaceHolderImage.dart';

class BannerPageView extends StatefulWidget {

  Function? onClickItem;
  bool? isSiteUrl;
  bool? isRoundedCorner;
  List<Banners> bannerList;
  double? height;
  double? dotMargin;
  BannerPageView(
      {super.key,
        this.isSiteUrl,
        this.isRoundedCorner,
        required this.bannerList,
        this.height,
        this.dotMargin,
        this.onClickItem});

  @override
  State<BannerPageView> createState() => _BannerPageViewState();
}

class _BannerPageViewState extends State<BannerPageView> {
  // declare and initizlize the page controller
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;
  // the index of the current page
  int _activePage = 0;

@override
  void initState() {
    super.initState();
    if(widget.bannerList.length>1) {
       _timer= Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        _pageController.animateToPage(
          (_activePage < (widget.bannerList.length - 1)) ? (_activePage + 1) : 0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.height??0)>0?(widget.height??0):140,
      child: Stack(
        alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: widget.bannerList.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.isRoundedCorner==true?
                Container(
                  margin: const EdgeInsets.only(left: 7,right: 7/*,top: 10*/),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                     child: _getImage( widget.isSiteUrl==true?widget.bannerList[index].siteResourceUrl??"":widget.bannerList![index].resourceUrl??"")),
                ):
                _getImage( widget.isSiteUrl==true?widget.bannerList[index].siteResourceUrl??"":widget.bannerList![index].resourceUrl??"");
              },
            ),
           if( widget.bannerList.length>1)
            Container(
              margin: EdgeInsets.only(bottom: (widget.dotMargin??0)>0?(widget.dotMargin??0):8),
             /* decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),*/
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    widget.bannerList.length, (index) => Padding(padding: const EdgeInsets.all( 5),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: _activePage == index
                              ? Colors.amber
                              : Colors.grey,
                        ),
                      ),
                    )),
              ),
            )
          ],
      ),
    );
  }

  CachePlaceHolderImage _getImage(String imageUrl){
  return CachePlaceHolderImage(imageUrl: imageUrl,
      fit: BoxFit.fill,
      imageHeight: double.infinity,
      imgaeWidth: double.infinity,
      errorIconHeight: 80,
      errorColorBackground: gray_1,
      errorColorIcon:gray_3);
  }

  @override
  void dispose() {
    _pageController.dispose();
    if(_timer!=null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}