import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Project"),
        actions: [
          IconButton(
            onPressed: () => _onUpload(),
            icon: const Icon(Icons.upload),
            tooltip: "Unggah",
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: context.watch<HomeProvider>().imagePath == null
                  ? const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image,
                        size: 100,
                      ),
                    )
                  : _showImage(),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _onGalleryView(),
                    child: const Text("Gallery"),
                  ),
                  ElevatedButton(
                    onPressed: () => _onCameraView(),
                    child: const Text("Camera"),
                  ),
                  ElevatedButton(
                    onPressed: () => _onCustomCameraView(),
                    child: const Text("Custom Camera"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onUpload() async {}

  _onGalleryView() async {
    final homeprovider = context.read<HomeProvider>();
    final ImagePicker imagepicker = ImagePicker();

    //pengecekan targetplatform karna fitur ini tidak ada di linux ataupun macos
    final bool islinux = defaultTargetPlatform == TargetPlatform.linux;
    final bool ismacos = defaultTargetPlatform == TargetPlatform.macOS;

    if (islinux||ismacos) return;
    //

    
    final XFile? picketfromgallery = await imagepicker.pickImage(
      source: ImageSource.gallery
    );

    if (picketfromgallery!= null) {
      homeprovider.setGamber(picketfromgallery);
      homeprovider.setImagePath(picketfromgallery.path);
    }
  }

  _onCameraView() async {

    final isandroid = defaultTargetPlatform == TargetPlatform.android;
    final isios = defaultTargetPlatform == TargetPlatform.iOS;

    final bool ismobile = !(isandroid||isios);
    if(ismobile)return;

    final ImagePicker picker = ImagePicker();
    final provider = context.read<HomeProvider>();

    final XFile? imagefromcamera = await picker.pickImage(source: ImageSource.camera);

    if(imagefromcamera!=null){
      provider.setGamber(imagefromcamera);
      provider.setImagePath(imagefromcamera.path);
    }
  }

  _onCustomCameraView() async {}

  Widget _showImage() {
    final imagepath = context.read<HomeProvider>().imagePath;
    return kIsWeb?Image.network(
          imagepath.toString(),
          fit: BoxFit.contain,
        )
      : Image.file(
          File(imagepath.toString()),
          fit: BoxFit.contain,
        );;
  }
}
