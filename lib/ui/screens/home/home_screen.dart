import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:video_status/controllers/category_controller.dart';
import 'package:video_status/controllers/home_list_controller.dart';
import 'package:video_status/controllers/video_controller.dart';
import 'package:video_status/ui/screens/video/video_screen.dart';
import 'package:video_status/ui/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_status/ui/utils/disable_scroll_glow.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  final ScrollController listScrollController = ScrollController();
  final HomeListAnimationController listAnimationController = HomeListAnimationController();
  final DisableScrollGlowBehavior disableScrollGlowBehavior = DisableScrollGlowBehavior();
  final CategoryController categoryController = CategoryController();
  VideoController videoController = VideoController();

  @override
  void initState() {
    super.initState();
    categoryController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    listScrollController.addListener(listScrollListner);
    return Container(
      child: GetBuilder<HomeListAnimationController>(
        init: listAnimationController,
        builder: (obj) => Column(
          children: [
            _buildTopSection(listAnimationController.isClosed),
            _buildMiddleSection(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  listScrollListner() {
    if (listScrollController.offset > 20 && videoController.videos.length > 1) {
      listAnimationController.setToClose();
    } else {
      listAnimationController.setToOpen();
    }
  }

  Expanded _buildBottomSection() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: disableScrollGlowBehavior,
        child: GetBuilder<VideoController>(
            init: videoController,
            builder: (videoController) {
              if (videoController.isLoaded == false) {
                return Center(child: CircularProgressIndicator());
              }
              if (videoController.isLoaded == true && videoController.videos.length == 0) {
                return Center(child: Text('No Video Found'));
              }
              if (videoController.videos.length > 0) {}
              return ListView.builder(
                controller: listScrollController,
                itemCount: videoController.videos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(VideoScreen(videoController.videos[index]));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.darken,
                                  ),
                                  fit: BoxFit.cover,
                                  image: NetworkImage(videoController.videos[index].featured),
                                ),
                              ),
                            ),
                          ),
                          Container(
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
                                        videoController.videos[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '00:30 | ${formatTime(videoController.videos[index].id)}',
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
                                    if (!videoController.checkLike(videoController.videos[index].id)) {
                                      videoController.likeVideo(videoController.videos[index].id);
                                    } else {
                                      videoController.unlikeVideo(videoController.videos[index].id);
                                    }
                                  },
                                  icon: FaIcon(FontAwesomeIcons.solidThumbsUp),
                                  color: videoController.checkLike(videoController.videos[index].id) ? primaryColor : grey,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  AnimatedContainer _buildMiddleSection() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      color: listAnimationController.isClosed ? primaryColor : Colors.white,
      margin: listAnimationController.isClosed ? EdgeInsets.zero : EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 4),
      width: double.infinity,
      height: 60,
      child: GetBuilder<CategoryController>(
        init: categoryController,
        builder: (categoryController) {
          if (categoryController.isLoaded == false) {
            return Container();
          }
          videoController.getVideos(categoryController.categories[0].id);
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    videoController.isLoaded = false;
                    videoController.update();
                    videoController.getVideos(categoryController.categories[index].id);
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: listAnimationController.isClosed ? Colors.white : primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Text(
                      categoryController.categories[index].title,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: listAnimationController.isClosed ? primaryColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AnimatedContainer _buildTopSection(bool isClosed) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: double.infinity,
      height: listAnimationController.isClosed ? 0 : Get.height / 2.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.7, 1],
          colors: [
            primaryColor,
            lightBlue,
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          listAnimationController.isClosed
              ? Container()
              : Text(
                  'Sehar Tere whatsapp status - 2020',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
          Expanded(
            child: ScrollConfiguration(
              behavior: disableScrollGlowBehavior,
              child: PageView.builder(
                physics: ClampingScrollPhysics(),
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://i.ytimg.com/vi/WrOXi6A3tHs/maxresdefault.jpg',
                        ),
                      ),
                    ),
                    margin: EdgeInsets.all(24),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.solidPlayCircle,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          listAnimationController.isClosed
              ? Container()
              : SmoothPageIndicator(
                  controller: pageController,
                  count: 5,
                  effect: SwapEffect(
                    dotColor: grey,
                    activeDotColor: primaryColor,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  },
                )
        ],
      ),
    );
  }
}
