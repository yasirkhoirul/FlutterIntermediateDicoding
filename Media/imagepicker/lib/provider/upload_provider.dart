import 'package:flutter/material.dart';
import 'package:imagepicker/data/api/storyapi.dart';
import 'package:imagepicker/data/model/model_story.dart';

class UploadProvider extends ChangeNotifier{
  bool isuploading = false;
  String message = '';
  ModelStory? uploadresponse;
  final Apiservice api;
  
  UploadProvider({required this.api});

  Future upload(
    List<int> bytes,
    String filename,
    String description
  )async{
    try {
      message = '';
      uploadresponse = null;
      isuploading = true;
      notifyListeners();

      uploadresponse = await api.upStory(bytes, filename, description);
      message = uploadresponse?.message??"succes";
      isuploading = false;
      notifyListeners();
    } catch (e) {
      isuploading = false;
      message = e.toString();
      notifyListeners();
    }
  }
}