


import 'package:flutter/material.dart';

void openDialog (context, title, message,[isPop = false]){
  showDialog(
    context: context,
    
    builder: (BuildContext context){
      return AlertDialog(
        content: Text(message),
        title: Text(title),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.pop(context);
              if(isPop){
                Navigator.pop(context);

              }
            },
            child: Text('OK'))
        ],

      );
    }
    
    );
}