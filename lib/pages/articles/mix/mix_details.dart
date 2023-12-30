import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news_app/models/article.dart';

import '../../../services/app_service.dart';
import '../../../utils/cached_image.dart';

class MixDetails extends StatelessWidget {
  const MixDetails({
    required this.er,
  });

  final MixModel er;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل المنوعات"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(er.title),
                      Divider(),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomCacheImage(
                            imageUrl: er.mediaUrl, radius: 5.0),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Icon(Feather.calendar),
                          SizedBox(
                            width: 10,
                          ),
                          Text(er.creationDate),
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تأمين الـأخطاء الطبية',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.6,
                            wordSpacing: 1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'إصدار فوري',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.6,
                            wordSpacing: 1),
                      ),
                      Text(
                        'تواصل معنا عبر:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.6,
                            wordSpacing: 1),
                      ),
                      InkWell(
                        onTap: () {
                          AppService().whatsapp(er.whatsApp);
                        },
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.asset(
                              "assets/images/whatsapp.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
