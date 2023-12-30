import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:news_app/models/training_course.dart';
import 'package:news_app/utils/cached_image.dart';
import 'package:news_app/utils/next_screen.dart';

class Card2 extends StatelessWidget {
  final TrainingCourse d;
  final String heroTag;

  const Card2({Key? key, required this.d, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ]),
        child: Wrap(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: heroTag,
                    child: CustomCacheImage(
                      imageUrl: d.mediaUrl,
                      radius: 5.0,
                      circularShape: false,
                    ),
                  ),
                ),
                if (d.hasOffer != null)
                  Container(
                    color: Colors.black38,
                    height: 40,
                    width: double.infinity,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      d.hasOffer ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                // VideoIcon(contentType: d.contentType, iconSize: 80,)
              ],
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      HtmlUnescape()
                          .convert(parse(d.description).documentElement!.text),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).secondaryHeaderColor)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.creationDate,
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      Spacer(),
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.loves.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).secondaryHeaderColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => navigateToDetailsScreen(context, d, heroTag),
    );
  }
}