import 'package:flutter/material.dart';
import 'package:news_app/models/employee_replacement.dart';

class EmployeeReplacementDetails extends StatelessWidget {
  const EmployeeReplacementDetails({
    required this.er,
  });

  final EmployeeReplacement er;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل النقل ببديل"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("تفاصيل الطلب"),
                      Divider(),
                      Text(er.title),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'التخصص الأساسي:   ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.6,
                                wordSpacing: 1),
                          ),
                          Text(er.currentPosition),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'تاريخ الطلب:   ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.6,
                                wordSpacing: 1),
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
                    children: [
                      Row(
                        children: [
                          Text(
                            'يبحث عن:   ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.6,
                                wordSpacing: 1),
                          ),
                          Text(er.searchFor),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'نوع التوظيف:   ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.6,
                                wordSpacing: 1),
                          ),
                          Text(er.jobType),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Text(
                            'مقر العمل ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.6,
                                wordSpacing: 1),
                          ),
                          Card(
                            elevation: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'المنطقة:   ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.6,
                                            wordSpacing: 1),
                                      ),
                                      Text(er.jobAddress),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'المدينة:   ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.6,
                                            wordSpacing: 1),
                                      ),
                                      Text(er.jobCity),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'اسم المنظمة:   ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.6,
                                            wordSpacing: 1),
                                      ),
                                      Text(er.organizationName),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("المناطق والمدن المراد الإنتقال إليها"),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(er.jobAddress),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
