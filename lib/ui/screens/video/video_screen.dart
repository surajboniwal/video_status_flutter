import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:video_player/video_player.dart';
import 'package:video_status/controllers/account_controller.dart';
import 'package:video_status/controllers/share_controller.dart';
import 'package:video_status/controllers/single_video_controller.dart';
import 'package:video_status/data/models/single_video.dart';
import 'package:video_status/data/models/video.dart';
import 'package:video_status/ui/screens/account/account_screen.dart';
import 'package:video_status/ui/screens/video/widgets/comment.dart';
import 'package:video_status/ui/screens/video/widgets/related_videos.dart';
import 'package:video_status/ui/screens/video/widgets/video_player.dart';
import 'package:video_status/ui/theme/colors.dart';
import 'package:video_status/ui/utils/disable_scroll_glow.dart';

class VideoScreen extends StatefulWidget {
  final Video video;
  VideoScreen(this.video);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController videoPlayerController;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.video.url);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: primaryColor));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<SingleVideoController>(
          init: SingleVideoController(),
          builder: (singleVideoController) {
            singleVideoController.getSingleVideo(widget.video.id);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChewieVideoItem(
                  videoPlayerController: videoPlayerController,
                  loop: false,
                ),
                _buildVideoInfoSection(singleVideoController),
                Expanded(
                  child: singleVideoController.singleVideo == null
                      ? Center(child: CircularProgressIndicator())
                      : _buildDownSection(singleVideoController),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDownSection(SingleVideoController singleVideoController) {
    List<Comment> comments = singleVideoController.singleVideo.comments;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ScrollConfiguration(
        behavior: DisableScrollGlowBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShareSection(),
              RelatedVideos(),
              _buildCommentSection(singleVideoController, comments),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Share', style: GoogleFonts.montserrat(fontSize: 16)),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GetBuilder<ShareController>(
                init: ShareController(),
                builder: (shareController) {
                  if (shareController.isDownloading) {
                    return CircularProgressIndicator();
                  }
                  return IconButton(
                    onPressed: () {
                      shareController.downloadAndShare(widget.video.url);
                    },
                    icon: FaIcon(
                      Icons.share,
                      color: primaryColor,
                    ),
                  );
                },
              ),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green)),
              IconButton(onPressed: () {}, icon: FaIcon(Icons.file_download, color: primaryColor)),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildCommentSection(SingleVideoController singleVideoController, List<Comment> comments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            signOutGoogle();
          },
          child: Text('Comments', style: GoogleFonts.montserrat(fontSize: 16)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: commentController,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              fillColor: Colors.green,
              hintText: 'Add a comment',
              suffixIcon: IconButton(
                onPressed: () {
                  if (getCurrentUser() == null) {
                    FocusScope.of(context).unfocus();
                    Get.to(AccountScreen());
                    Get.snackbar(
                      'Login alert',
                      'Please login with your google account to continue',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    singleVideoController.makeComment(commentController.text, widget.video.id, getCurrentUser().displayName);
                    FocusScope.of(context).unfocus();
                    commentController.text = '';
                  }
                },
                icon: Icon(Icons.send),
              ),
            ),
          ),
        ),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return buildCommentCard(comments[index]);
          },
        ),
      ],
    );
  }

  Container _buildVideoInfoSection(SingleVideoController singleVideoController) {
    String value;
    Duration duration;
    if (videoPlayerController.value.duration == null) {
      duration = Duration(minutes: 00, seconds: 00);
    } else {
      duration = videoPlayerController.value.duration;
    }
    value = duration.inMinutes.remainder(60).toString() + ':' + duration.inSeconds.remainder(60).toString();

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 18),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.video.title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  '$value | ${formatTime(widget.video.id)}',
                  style: GoogleFonts.montserrat(
                    textStyle: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              if (singleVideoController.isFav) {
                singleVideoController.unlikeVideo(widget.video.id);
              } else {
                singleVideoController.likeVideo(widget.video.id);
              }
            },
            icon: FaIcon(FontAwesomeIcons.solidThumbsUp),
            color: singleVideoController.isFav ? primaryColor : grey,
          )
        ],
      ),
    );
  }
}
