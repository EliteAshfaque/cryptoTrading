import 'dart:io';

import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class MessageAttachment extends StatefulWidget {

  final HelpDeskTicketStruct ticket;
  final TextEditingController msgController;

  const MessageAttachment({super.key, required this.ticket, required this.msgController});

  @override
  State<MessageAttachment> createState() => _MessageAttachmentState();
}

class _MessageAttachmentState extends State<MessageAttachment> {

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //   widget.showLoader(true);
    //   debugPrint('progress: $progress');
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // _subscription!.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      height: 90.0,
      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MessageAttachmentCard(
            iconData: Icons.camera_alt,
            title: "Camera",
            press: () async{
              final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
              if(photo != null) {
                //getLostData();
                if (kDebugMode){print(photo.path);}
                addMessage(File(photo.path), photo.name);
              }
            },
          ),
          MessageAttachmentCard(
            iconData: Icons.image,
            title: "Gallery",
            press: () async {
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if(image != null) {
                if (kDebugMode){print(image.path);}
                addMessage(File(image.path), image.name);
              }
            },
          ),
          // MessageAttachmentCard(
          //   iconData: Icons.headset,
          //   title: "Audio",
          //   press: () {},
          // ),
          MessageAttachmentCard(
            iconData: Icons.videocam,
            title: "Video",
            press: () async {
              final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
              if(video != null) {
                if (kDebugMode){print(video.path);}
                // compressing video to low quality....
                MediaInfo? mediaInfo = await VideoCompress.compressVideo(
                  video.path,
                  quality: VideoQuality.LowQuality,
                  deleteOrigin: false, // It's false by default
                );
                if(mediaInfo != null) {
                  addMessage(File(mediaInfo.path!), mediaInfo.title!);
                }
              }
              //toastMe.showToast("Functionality Yet to implement");
            },
          ),
        ],
      ),
    );
  }

  addMessage(File file, String imageName) async {
    Map<String,dynamic> map = new Map();
    map['attachments'] = file;
    if(widget.msgController.text.isNotEmpty) {
      map['reply'] = widget.msgController.text;
    }
    map['id'] = widget.ticket.id!;
    map['user_id'] = widget.ticket.requester_id!;
    int fileSizeInBytes = await file.length();
    double fileSizeInKB = fileSizeInBytes / 1024;
    double fileSizeInMB = fileSizeInKB / 1024;
    if (kDebugMode){print(fileSizeInMB);}
    if(fileSizeInMB < 2) {
      apiCalls.createReplyWithDocs(map, context);
      LoadingOverlay.showLoader(context);
    }else {
      showToast('Size greater then 2 MB.',gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
    }
    Navigator.pop(context);
  }

}

class MessageAttachmentCard extends StatelessWidget {
  final VoidCallback press;
  final IconData iconData;
  final String title;

  const MessageAttachmentCard(
      {Key? key,
      required this.press,
      required this.iconData,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            Text(
              title,
              style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),),
            )
          ],
        ),
      ),
    );
  }
}
