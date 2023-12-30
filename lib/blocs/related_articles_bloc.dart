
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/models/training_course.dart';

class RelatedBloc extends ChangeNotifier{
  
  List<TrainingCourse> _data = [];
  List<TrainingCourse> get data => _data;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 

  Future getData( String? timestamp) async {
    _data.clear();
    QuerySnapshot rawData;
      rawData = await firestore
          .collection('contents')
          .where('timestamp', isNotEqualTo: timestamp)
          .orderBy('timestamp', descending: true)
          .limit(5)
          .get();
      
      List<DocumentSnapshot> _snap = [];
      _snap.addAll(rawData.docs);
      _data = _snap.map((e) => TrainingCourse.fromFirestore(e)).toList();
      notifyListeners();
    
    
  }

  onRefresh(mounted,String timestamp) {
    _data.clear();
    getData( timestamp);
    notifyListeners();
  }




}