import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/training_course.dart';
import 'package:news_app/pages/articles/em_re/em_details.dart';
import 'package:news_app/pages/articles/mix/mix_details.dart';
import 'package:news_app/utils/cached_image.dart';
import 'package:news_app/utils/next_screen.dart';

import '../models/employee_replacement.dart';

class SliverCard1 extends StatelessWidget {
  final TrainingCourse d;
  final String heroTag;

  const SliverCard1({Key? key, required this.d, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey[600]),
                          child: Text(
                            d.createdBy,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Hero(
                      tag: heroTag,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomCacheImage(
                                imageUrl: d.mediaUrl, radius: 5.0),
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
                          // VideoIcon(contentType: d.contentType, iconSize: 40,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.time,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    d.creationDate,
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 13),
                  ),
                  Spacer(),
                  Icon(
                    Icons.favorite,
                    color: Theme.of(context).secondaryHeaderColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(d.loves.toString(),
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 13)),
                ],
              )
            ],
          )),
      onTap: () => navigateToDetailsScreen(context, d, heroTag),
    );
  }
}

//employee replacement courses
class SliverCard2 extends StatelessWidget {
  final EmployeeReplacement d;
  final String heroTag;

  const SliverCard2({Key? key, required this.d, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmployeeReplacementDetails(er: d),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(d.title),
              Divider(),
              Row(
                children: [
                  Icon(Feather.calendar),
                  SizedBox(
                    width: 10,
                  ),
                  Text(d.creationDate),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(d.currentPosition),
                  Spacer(),
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.grey,
                  ),
                  Spacer(),
                  Text(d.neededPosition),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//mix courses
class SliverCard3 extends StatelessWidget {
  final MixModel d;
  final String heroTag;

  const SliverCard3({Key? key, required this.d, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MixDetails(er: d),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(d.title),
              Divider(),
              Hero(
                tag: heroTag,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomCacheImage(
                          imageUrl: d.mediaUrl, radius: 5.0),
                    ),

                    // VideoIcon(contentType: d.contentType, iconSize: 40,)
                  ],
                ),
              ),

              Divider(),
              Row(
                children: [
                  Icon(Feather.calendar),
                  SizedBox(
                    width: 10,
                  ),
                  Text(d.creationDate),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
