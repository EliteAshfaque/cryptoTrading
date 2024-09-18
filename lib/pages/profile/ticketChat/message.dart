import 'package:cryptox/api/helpDesk/allConversations/allConversations.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Message extends StatefulWidget {

  final ConversationsStruct con;
  final HelpDeskTicketStruct ticket;

  const Message({super.key, required this.con, required this.ticket});

  @override
  State<Message> createState() => _Message();
}

class _Message extends State<Message> {

  VideoPlayerController? _controller;
  bool loadingVideo = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.con.attachments!.length > 0) {
      if(widget.con.attachments![0].content_type!.contains("video")) {
        _controller = VideoPlayerController.network(widget.con.attachments![0].attachment_url!)
          ..initialize().then((_) {
            setState(() {
              loadingVideo = false;
            });
          }).onError((error, stackTrace) {
            print("ERROR WHILE PLAYING VIDEO "+error.toString());
          });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(_controller != null){
      _controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool flag = widget.con.user_id! == widget.ticket.requester_id;
    return widget.con.attachments!.length > 0 ? Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      // width: 200,
      // height: 200,
      child: Align(
        alignment: (!flag ? Alignment.topLeft : Alignment.topRight),
        child: checkForRender(widget.con),
      ),
    ) : Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      child: Align(
        alignment: (!flag ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ( flag ? Colors.grey.shade200 : primaryColor),
          ),
          padding: EdgeInsets.all(16),
          child: Text(widget.con.body_text!, style: TextStyle(fontSize: 15,
              color: flag ? Colors.black54 : Colors.white)),
        ),
      ),
    );
  }

  checkForRender(ConversationsStruct item) {
    AttachmentsStruct attach = item.attachments![0];
    bool flag = widget.con.user_id! == widget.ticket.requester_id;
    if(attach.content_type!.contains("image")) {
      return Column(
        crossAxisAlignment: flag ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(item: item);
              }));
            },
            child: Hero(
              tag: item.created_at.toString(),
              child: Container(
                width: 200,
                height: 200,
                child: Image.network(item.attachments![0].attachment_url!,fit: BoxFit.fill,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                          value: loadingProgress.expectedTotalBytes != null ?
                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if(widget.con.body_text != "image")
            Container(
              constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: (flag ? Colors.grey.shade200 : primaryColor),
              ),
              padding: EdgeInsets.all(16),
              child: Text(widget.con.body_text!, style: TextStyle(fontSize: 15,
                  color: flag ? Colors.black54 : Colors.white)),
            ),
        ],
      );
    }else if(attach.content_type!.contains("video")) {
      return Column(
        crossAxisAlignment: flag ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return VideoDetailScreen(
                    item: widget.con, controller: _controller!);
              }));
            },
            child: Hero(
              tag: item.created_at.toString(),
              // child: Center(child: CircularProgressIndicator()),
              child: loadingVideo
                  ? CircularProgressIndicator()
                  : Container(
                      width: 200,
                      height: 200,
                      child: VideoPlayer(_controller!)),
            ),
          ),
          if(widget.con.body_text != "image")
            Container(
              constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: (flag ? Colors.grey.shade200 : primaryColor),
              ),
              padding: EdgeInsets.all(16),
              child: Text(widget.con.body_text!, style: TextStyle(fontSize: 15,
                  color: flag ? Colors.black54 : Colors.white)),
            ),
        ],
      );
    }else {
      Text("Message Type not cleared.",style: TextStyle(color: Colors.red));
    }
  }

}

class DetailScreen extends StatelessWidget {

  final ConversationsStruct item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: item.created_at.toString(),
            child: Image.network(
              item.attachments![0].attachment_url!,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class VideoDetailScreen extends StatefulWidget {

  final ConversationsStruct item;
  final VideoPlayerController controller;

  VideoDetailScreen({required this.item, required this.controller});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: widget.item.created_at.toString(),
            child: VideoPlayer(widget.controller)
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
          });
        },
        child: Icon(
          widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
