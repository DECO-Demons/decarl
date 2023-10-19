import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:decarl/firebase_manager.dart';

class ARBackendInterface {
    FirebaseManager firebaseManager = FirebaseManager();
    Map<String, Map> anchorsInDownloadProgress = Map<String, Map>();
    ARAnchorManager? arAnchorManager;
}
