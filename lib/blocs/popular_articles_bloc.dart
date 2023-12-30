import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/training_course.dart';

class PopularBloc extends ChangeNotifier {
  List<TrainingCourse> _data = [];

  List<TrainingCourse> get data => _data;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getData() async {
    QuerySnapshot rawData;
    rawData = await firestore
        .collection('contents')
        .where('isPublished', isEqualTo: true)
        .orderBy('loves', descending: true)
        .limit(5)
        .get();

    List<DocumentSnapshot> _snap = [];
    _snap.addAll(rawData.docs);
    _data = _snap.map((e) => TrainingCourse.fromFirestore(e)).toList();
    notifyListeners();
  }

  onRefresh() {
    _data.clear();
    getData();
    notifyListeners();
  }
}
