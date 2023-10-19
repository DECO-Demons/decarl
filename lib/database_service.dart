import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'data_classes/Art.dart';

class DatabaseService {
    final DatabaseReference _db = FirebaseDatabase.instance.ref(); // not correct? use realtimedatabase
}
