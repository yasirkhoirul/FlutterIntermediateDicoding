import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget{
  final List<CameraDescription> camera;
  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  bool iscamerainitialization = false;

  CameraController? cameraController;

  void onNewcameraselected(CameraDescription camera) async{
    final prevcameracontroller = cameraController;
    final cameracontrooler = CameraController(
      camera, 
      ResolutionPreset.medium
      );

    await prevcameracontroller?.dispose();
    try {
      await cameracontrooler.initialize();
    } on CameraException catch (e) {
      print("error pada kamera : $e");
    }

    if(mounted){
      setState(() {
        cameraController = cameracontrooler;
        iscamerainitialization = cameraController!.value.isInitialized;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? controller = cameraController;
    if(controller == null || !controller.value.isInitialized){
      return;
    }
    if(state == AppLifecycleState.inactive){
      controller.dispose();
    }else if (state == AppLifecycleState.resumed){
      onNewcameraselected(controller.description);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    onNewcameraselected(widget.camera.first);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData.dark(), child: Scaffold(
      appBar: AppBar(
        title: const Text("Ambil Gambar"),
        actions: [
          IconButton(onPressed: (){
            onCameraSwitch();
          },icon: Icon(Icons.cameraswitch),)
        ],
      ),
      body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              iscamerainitialization?
              CameraPreview(cameraController!):
              const Center(child: CircularProgressIndicator(),),
              Align(
                alignment: const Alignment(0, 0.95),
                child: _actionWidget(),
              ),
            ],
          ),
        ),
    ));
  }
  Widget _actionWidget() {
    return FloatingActionButton(
      heroTag: "take-picture",
      tooltip: "Ambil Gambar",
      onPressed: () => _onCameraButtonClick(),
      child: const Icon(Icons.camera_alt),
    );
  }

  Future<void> _onCameraButtonClick() async {
    final image = await cameraController?.takePicture();
    final navigator = Navigator.of(context);

    navigator.pop(image);
  }

  void onCameraSwitch(){

  }
}