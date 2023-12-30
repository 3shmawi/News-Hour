import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news_app/blocs/ads_bloc.dart';
import 'package:news_app/blocs/bookmark_bloc.dart';
import 'package:news_app/blocs/sign_in_bloc.dart';
import 'package:news_app/blocs/theme_bloc.dart';
import 'package:news_app/models/training_course.dart';
import 'package:news_app/models/custom_color.dart';
import 'package:news_app/pages/comments.dart';
import 'package:news_app/services/app_service.dart';
import 'package:news_app/utils/cached_image.dart';
import 'package:news_app/utils/sign_in_dialog.dart';
import 'package:news_app/widgets/banner_ad_admob.dart'; //admob
//import 'package:news_app/widgets/banner_ad_fb.dart';      //fb ad
import 'package:news_app/widgets/bookmark_icon.dart';
import 'package:news_app/widgets/love_count.dart';
import 'package:news_app/widgets/love_icon.dart';
import 'package:news_app/widgets/related_articles.dart';
import 'package:news_app/widgets/views_count.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '../../../utils/next_screen.dart';
import '../../../widgets/html_body.dart';

class ArticleDetails extends StatefulWidget {
  final TrainingCourse? data;
  final String? tag;

  const ArticleDetails({Key? key, required this.data, required this.tag})
      : super(key: key);

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  double rightPaddingValue = 130;

  void _handleShare() {
    final sb = context.read<SignInBloc>();
    final String _shareTextAndroid =
        '${widget.data!.title}, Check out this app to explore more. App link: https://play.google.com/store/apps/details?id=${sb.packageName}';
    final String _shareTextiOS =
        '${widget.data!.title}, Check out this app to explore more. App link: https://play.google.com/store/apps/details?id=${sb.packageName}';

    if (Platform.isAndroid) {
      Share.share(_shareTextAndroid);
    } else {
      Share.share(_shareTextiOS);
    }
  }

  handleLoveClick() {
    bool _guestUser = context.read<SignInBloc>().guestUser;

    if (_guestUser == true) {
      openSignInDialog(context);
    } else {
      context.read<BookmarkBloc>().onLoveIconClick(widget.data!.timestamp);
    }
  }

  handleBookmarkClick() {
    bool _guestUser = context.read<SignInBloc>().guestUser;

    if (_guestUser == true) {
      openSignInDialog(context);
    } else {
      context.read<BookmarkBloc>().onBookmarkIconClick(widget.data!.timestamp);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        rightPaddingValue = 10;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    final TrainingCourse article = widget.data!;
    const path = "assets/images";
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: true,
          top: false,
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    _customAppBar(article, context),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: context
                                                          .watch<ThemeBloc>()
                                                          .darkTheme ==
                                                      false
                                                  ? CustomColor()
                                                      .loadingColorLight
                                                  : CustomColor()
                                                      .loadingColorDark,
                                            ),
                                            child: AnimatedPadding(
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: rightPaddingValue,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                article.createdBy,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )),
                                        Spacer(),
                                        IconButton(
                                            icon: BuildLoveIcon(
                                                collectionName: 'contents',
                                                uid: sb.uid,
                                                timestamp: article.timestamp),
                                            onPressed: () {
                                              handleLoveClick();
                                            }),
                                        IconButton(
                                            icon: BuildBookmarkIcon(
                                                collectionName: 'contents',
                                                uid: sb.uid,
                                                timestamp: article.timestamp),
                                            onPressed: () {
                                              handleBookmarkClick();
                                            }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.date_range,
                                            size: 20, color: Colors.grey),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          article.creationDate,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(CupertinoIcons.timer,
                                            size: 18, color: Colors.grey),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          AppService.getReadingTime(
                                              article.description!),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize: 12),
                                        ),
                                        Spacer(),
                                        Text(
                                          article.limitedSets
                                              ? "عدد المقاعد محدود"
                                              : "عدد المقاعد لا محدود",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      article.title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.6,
                                          wordSpacing: 1),
                                    ),
                                    Divider(
                                      color: Theme.of(context).primaryColor,
                                      endIndent: 200,
                                      thickness: 2,
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        TextButton.icon(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty
                                                .resolveWith((states) =>
                                                    EdgeInsets.only(
                                                        left: 10, right: 10)),
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        Theme.of(context)
                                                            .primaryColor),
                                            shape: MaterialStateProperty
                                                .resolveWith((states) =>
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3))),
                                          ),
                                          icon: Icon(Feather.message_circle,
                                              color: Colors.white, size: 20),
                                          label: Text(
                                            'comments',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ).tr(),
                                          onPressed: () {
                                            nextScreen(
                                                context,
                                                CommentsPage(
                                                    timestamp:
                                                        article.timestamp));
                                          },
                                        ),
                                        const Spacer(),
                                        if (article.registrationLink != null)
                                          TextButton.icon(
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty
                                                  .resolveWith((states) =>
                                                      EdgeInsets.only(
                                                          left: 10, right: 10)),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) =>
                                                          Theme.of(context)
                                                              .primaryColor),
                                              shape: MaterialStateProperty
                                                  .resolveWith((states) =>
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3))),
                                            ),
                                            icon: Icon(Feather.send,
                                                color: Colors.white, size: 20),
                                            label: Text(
                                              'register',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ).tr(),
                                            onPressed: () => AppService()
                                                .openLinkWithCustomTab(context,
                                                    article.registrationLink!),
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        //views feature
                                        ViewsCount(
                                          article: article,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),

                                        LoveCount(
                                            collectionName: 'contents',
                                            timestamp: article.timestamp),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: HtmlBodyWidget(
                                  content: article.description ??
                                      'There is no description',
                                  isIframeVideoEnabled: true,
                                  isVideoEnabled: true,
                                  isimageEnabled: true,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Feather.calendar),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Beginning date").tr(),
                                          Spacer(),
                                          Text(
                                            _d(article.courseBeginningDate),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Icon(Feather.calendar),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Ending date").tr(),
                                          Spacer(),
                                          Text(
                                            _d(article.courseEndingDate),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Icon(Feather.calendar),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Days").tr(),
                                          Spacer(),
                                          Text(
                                            article.courseDays.toString(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Icon(Feather.clock),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Hours").tr(),
                                          Spacer(),
                                          Text(
                                            article.courseHours.toString(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Icon(Feather.calendar),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("register round").tr(),
                                          Spacer(),
                                          Text(
                                            "${"From".tr()} ${_d(article.availableFrom)} \n${"To".tr()} ${_d(article.availableTo)}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'الجهة المنظمة:   ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: -0.6,
                                                wordSpacing: 1),
                                          ),
                                          Text(article.organizedBy),
                                        ],
                                      ),
                                      Divider(),
                                      if (article.accreditedEntities != null)
                                        Row(
                                          children: [
                                            Text(
                                              'جهات الإعتماد:   ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: -0.6,
                                                  wordSpacing: 1),
                                            ),
                                            Text(article.accreditedEntities!),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        'contacts',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.6,
                                            wordSpacing: 1),
                                      ),
                                      Divider(),
                                      Wrap(
                                        children: [
                                          if (article.whatsApp != null)
                                            InkWell(
                                              onTap: () {
                                                AppService().whatsapp(
                                                    article.whatsApp ?? "");
                                              },
                                              child: SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: Image.asset(
                                                    "$path/whatsapp.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          // if (article.telegram != null)
                                          //   InkWell(
                                          //     onTap: () {},
                                          //     child: SizedBox(
                                          //       height: 60,
                                          //       width: 60,
                                          //       child: Card(
                                          //         clipBehavior: Clip
                                          //             .antiAliasWithSaveLayer,
                                          //         child: Image.asset(
                                          //           "$path/telegram.png",
                                          //           fit: BoxFit.cover,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          if (article.website != null)
                                            InkWell(
                                              onTap: () {
                                                AppService().launchInBrowser(
                                                  Uri.parse(
                                                      article.website ?? ""),
                                                );
                                              },
                                              child: SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: Image.asset(
                                                    "$path/website.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (article.phone != null)
                                            InkWell(
                                              onTap: () {
                                                AppService().makePhoneCall(
                                                    article.phone ?? "");
                                              },
                                              child: SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: Image.asset(
                                                    "$path/phone.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (article.email != null)
                                            InkWell(
                                              onTap: () {
                                                AppService().openEmailSupport(
                                                  context,
                                                  article.email ?? "",
                                                );
                                              },
                                              child: SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: Image.asset(
                                                    "$path/email.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: RelatedArticles(
                              timestamp: article.timestamp,
                              replace: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // -- Banner ads --

              context.watch<AdsBloc>().bannerAdEnabled == false
                  ? Container()
                  : BannerAdAdmob() //admob
              //: BannerAdFb()    //fb
            ],
          ),
        ));
  }

  SliverAppBar _customAppBar(TrainingCourse article, BuildContext context) {
    return SliverAppBar(
      expandedHeight: 270,
      flexibleSpace: FlexibleSpaceBar(
          background: widget.tag == null
              ? CustomCacheImage(imageUrl: article.mediaUrl, radius: 0.0)
              : Hero(
                  tag: widget.tag!,
                  child:
                      CustomCacheImage(imageUrl: article.mediaUrl, radius: 0.0),
                )),
      leading: IconButton(
        icon:
            const Icon(Icons.keyboard_backspace, size: 22, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share, size: 22, color: Colors.white),
          onPressed: () {
            _handleShare();
          },
        ),
        SizedBox(
          width: 5,
        )
      ],
    );
  }

  String _d(String date) {
    return DateFormat('dd MMMM yyyy').format(
      DateTime.parse("$date 00:00:00.000"),
    );
  }
}
