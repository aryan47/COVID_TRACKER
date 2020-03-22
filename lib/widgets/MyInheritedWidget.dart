
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';


class MyInheritedWidget extends InheritedWidget {
   MyInheritedWidget({
      Key key,
      @required Widget child,
      this.data,
   }): super(key: key, child: child);
	
   final data;
   BehaviorSubject _refresh =  BehaviorSubject.seeded(false);

   BehaviorSubject get refresh => _refresh;
	
   static MyInheritedWidget of(BuildContext context) {
     return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
   }

   @override
   bool updateShouldNotify(MyInheritedWidget oldWidget) => data != oldWidget.data;
}