import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:decarl/components/appcolors.dart';
import 'package:decarl/components/roundbutton.dart';
import 'package:decarl/firebase_manager.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:vector_math/vector_math_64.dart' as VectorMath;

class ARWidget extends StatefulWidget {
  ARWidget({Key? key}) : super(key: key);
  @override
  _ARWidgetState createState() =>
      _ARWidgetState();
}

Object initialArSessionManagerOpts = {

};

class _ARWidgetState
    extends State<ARWidget> {
  // Firebase stuff
  bool _initialized = false;
  bool _error = false;
  FirebaseManager firebaseManager = FirebaseManager();
  Map<String, Map> anchorsInDownloadProgress = Map<String, Map>();

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];
  String lastUploadedAnchor = "";
  AvailableModel selectedModel = AvailableModel(
      "Duck",
      "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb",
      "");

  bool choosingModel = false;
  bool placingModel = false;
  bool modelChoiceActive = false;

  @override
  void initState() {
    firebaseManager.initializeFlutterFire().then((value) => setState(() {
          _initialized = value;
          _error = !value;
        }));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
    print("Disposed AR screen");
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Scaffold(
          // appBar: AppBar(
          //   title: const Text('External Model Management'),
          // ),
          body: Container(
              child: Center(
                  child: Column(
            children: [
              Text("Firebase initialization failed"),
              ElevatedButton(
                  child: Text("Retry"), onPressed: () => {initState()})
            ],
          ))));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Scaffold(
          // appBar: AppBar(
          //   title: const Text('External Model Management'),
          // ),
          body: Container(
              child: Center(
                  child: Column(children: [
            CircularProgressIndicator(),
            Text("Initializing Firebase")
          ]))));
    }

    return Scaffold(
        body: Container(
            child: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
            alignment: FractionalOffset.topRight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundButton(
                    icon: const Icon(
                      LucideIcons.boxes,
                      color: AppColors.grey900,
                    ),
                    onPressed: () {
                      setState(() {
                        modelChoiceActive = !modelChoiceActive;
                      });
                    },
                    color: AppColors.tertiary500,
                    pressedColor: AppColors.tertiary700,
                  ),
                  SizedBox(width: 10),
                  Visibility(
                    visible: !placingModel,
                    child: RoundButton(
                      icon: const Icon(
                        LucideIcons.plus,
                        color: AppColors.grey900,
                      ),
                      onPressed: startPlacingAnchor,
                      color: AppColors.tertiary500,
                      pressedColor: AppColors.tertiary700,
                    )
                  ),
                  Visibility(
                    visible: placingModel,
                    child: RoundButton(
                      icon: const Icon(
                        LucideIcons.plus,
                        color: AppColors.grey900,
                      ),
                      onPressed: uploadLatestAnchor,
                      color: AppColors.primary500,
                      pressedColor: AppColors.primary700,
                    )
                  ),
                  SizedBox(width: 10),
                  RoundButton(
                    icon: const Icon(
                      LucideIcons.refreshCw,
                      color: AppColors.grey900,
                    ),
                    onPressed: refreshAnchors,
                    color: AppColors.tertiary500,
                    pressedColor: AppColors.tertiary700,
                    ),
                ]),
          ),
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Visibility(
                  visible: modelChoiceActive,
                  child: ModelSelectionWidget(
                      onTap: onModelSelected,
                      firebaseManager: this.firebaseManager)))
        ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;
    this.arLocationManager = arLocationManager;

    this.arSessionManager!.onInitialize(
        showPlanes: false,
        customPlaneTexturePath: "Images/triangle.png",
    );
    this.arAnchorManager!.initGoogleCloudAnchorMode();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arAnchorManager!.onAnchorUploaded = onAnchorUploaded;
    this.arAnchorManager!.onAnchorDownloaded = onAnchorDownloaded;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;

    this
        .arLocationManager!
        .startLocationUpdates()
        .then((value) => null)
        .onError((error, stackTrace) {
      switch (error.toString()) {
        case 'Location services disabled':
          {
            showAlertDialog(
                context,
                "Action Required",
                "To use cloud anchor functionality, please enable your location services",
                "Settings",
                this.arLocationManager!.openLocationServicesSettings,
                "Cancel");
            break;
          }

        case 'Location permissions denied':
          {
            showAlertDialog(
                context,
                "Action Required",
                "To use cloud anchor functionality, please allow the app to access your device's location",
                "Retry",
                this.arLocationManager!.startLocationUpdates,
                "Cancel");
            break;
          }

        case 'Location permissions permanently denied':
          {
            showAlertDialog(
                context,
                "Action Required",
                "To use cloud anchor functionality, please allow the app to access your device's location",
                "Settings",
                this.arLocationManager!.openAppPermissionSettings,
                "Cancel");
            break;
          }

        default:
          {
            this.arSessionManager!.onError(error.toString());
            break;
          }
      }
      this.arSessionManager!.onError(error.toString());
    });
  }

  void startPlacingAnchor() {
    setState(() {
        placingModel = true;
    });
    arSessionManager!.onInitialize(
        showPlanes: true,
        handlePans: true,
        handleRotation: true,
    );
  }
  
  Future<void> uploadLatestAnchor() async {
    this.arAnchorManager!.uploadAnchor(this.anchors.last);
    setState(() {
      placingModel = false;
    });
    this.arSessionManager!.onInitialize(
        showPlanes: false,
        customPlaneTexturePath: "Images/triangle.png",
    );
  }
  
  Future<void> downloadAnchors() async {
    // Get anchors within a radius of 100m of the current device's location
    if (this.arLocationManager!.currentLocation != null) {
      firebaseManager.downloadAnchorsByLocation((snapshot) {
        final cloudAnchorId = snapshot.get("cloudanchorid");
        anchorsInDownloadProgress[cloudAnchorId] =
            snapshot.data() as Map<String, dynamic>;
        arAnchorManager!.downloadAnchor(cloudAnchorId);
      }, this.arLocationManager!.currentLocation, 0.1);
    } else {
      this
          .arSessionManager!
          .onError("Location updates not running, can't download anchors");
    }
  }
  
  Future<void> removeVisibleAnchors() async {
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> refreshAnchors() async {
    await removeVisibleAnchors();
    await downloadAnchors();
  }

  void onModelSelected(AvailableModel model) {
    this.selectedModel = model;
    this.arSessionManager!.onError(model.name + " selected");
    setState(() {
      modelChoiceActive = false;
    });
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor = ARPlaneAnchor(
          transformation: singleHitTestResult.worldTransform, ttl: 1);
      bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor!) {
        this.anchors.add(newAnchor);
        // Add node to anchor
        var newNode = ARNode(
            type: NodeType.webGLB,
            uri: this.selectedModel.uri.toString(),
            scale: VectorMath.Vector3(0.2, 0.2, 0.2),
            position: VectorMath.Vector3(0.0, 0.0, 0.0),
            rotation: VectorMath.Vector4(1.0, 0.0, 0.0, 0.0),
            data: {"onTapText": "I am a " + this.selectedModel.name});
        bool? didAddNodeToAnchor = await this
            .arObjectManager!
            .addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          this.nodes.add(newNode);
        } else {
          this.arSessionManager!.onError("Adding Node to Anchor failed");
        }
      } else {
        this.arSessionManager!.onError("Adding Anchor failed");
      }
    }
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
    // If in edit mode do nothing
    // If not in edit mode, open modal with info
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
    final pannedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);
    pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
    final rotatedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);

    rotatedNode.transform = newTransform;
  }

  onAnchorUploaded(ARAnchor anchor) {
    // Upload anchor information to firebase
    firebaseManager.uploadAnchor(anchor,
        currentLocation: this.arLocationManager!.currentLocation);
    // Upload child nodes to firebase
    if (anchor is ARPlaneAnchor) {
      anchor.childNodes.forEach((nodeName) => firebaseManager.uploadObject(
          nodes.firstWhere((element) => element.name == nodeName)));
    }
    setState(() {
      placingModel = false;
    });
    this.arSessionManager!.onError("Upload successful");
  }

  ARAnchor onAnchorDownloaded(Map<String, dynamic> serializedAnchor) {
    final anchor = ARPlaneAnchor.fromJson(
        anchorsInDownloadProgress[serializedAnchor["cloudanchorid"]]
            as Map<String, dynamic>);
    anchorsInDownloadProgress.remove(anchor.cloudanchorid);
    this.anchors.add(anchor);

    // Download nodes attached to this anchor
    firebaseManager.getObjectsFromAnchor(anchor, (snapshot) {
      snapshot.docs.forEach((objectDoc) {
        ARNode object =
            ARNode.fromMap(objectDoc.data() as Map<String, dynamic>);
        arObjectManager!.addNode(object, planeAnchor: anchor);
        this.nodes.add(object);
      });
    });

    return anchor;
  }


  void showAlertDialog(BuildContext context, String title, String content,
      String buttonText, Function buttonFunction, String cancelButtonText) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text(cancelButtonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget actionButton = ElevatedButton(
      child: Text(buttonText),
      onPressed: () {
        buttonFunction();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        actionButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class AvailableModel {
  String name;
  String uri;
  String image;
  AvailableModel(this.name, this.uri, this.image);
}

class ModelSelectionWidget extends StatefulWidget {
  final Function onTap;
  final FirebaseManager firebaseManager;

  ModelSelectionWidget({required this.onTap, required this.firebaseManager});

  @override
  _ModelSelectionWidgetState createState() => _ModelSelectionWidgetState();
}

class _ModelSelectionWidgetState extends State<ModelSelectionWidget> {
  List<AvailableModel> models = [];

  String? selected;

  @override
  void initState() {
    super.initState();
    widget.firebaseManager.downloadAvailableModels((snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          print(element.get("uri"));
          models.add(AvailableModel(
              element.get("name"), element.get("uri"), element.get("image")));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                style: BorderStyle.solid,
                width: 4.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              shape: BoxShape.rectangle,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 10.0,
                  spreadRadius: 4.0,
                )
              ],
            ),
            child: Text('Choose a Model',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0)),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.65,
            child: ListView.builder(
              itemCount: models.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onTap(models[index]);
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(models[index].image)),
                        Text(
                          models[index].name,
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 1.0),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ]);
  }
}
