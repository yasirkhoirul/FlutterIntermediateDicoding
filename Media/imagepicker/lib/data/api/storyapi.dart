import 'dart:typed_data';

import 'package:imagepicker/data/model/model_story.dart';
import 'package:http/http.dart' as http;

class Apiservice {

  
  Future<ModelStory> upStory(
    List<int> bytess,
    String filename,
    String description,
  ) async {
    const String url = "https://story-api.dicoding.dev/v1/stories/guest";
    final uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    final multipart = http.MultipartFile.fromBytes(
      "photo",
      bytess,
      filename: filename,
    );

    final Map<String,String> field = {
      'description':description
    };

    final Map<String,String> headers = {
      'Content-type':'multipart/form-data'
    };

    request.files.add(multipart);
    request.fields.addAll(field);
    request.headers.addAll(headers);

    //http.StreamedResponse masih berupa aliran data (stream) — belum dikumpulkan sepenuhnya.
    final http.StreamedResponse stremstreamedResponse = await request.send();
    final int statuscode = stremstreamedResponse.statusCode;

    final Uint8List responselist = await stremstreamedResponse.stream.toBytes();
    final String responsedata = String.fromCharCodes(responselist);



    if(statuscode == 201){
      final ModelStory uploadResponse = ModelStory.fromjson(
        responsedata
      );
      return uploadResponse;
    }else{
      throw Exception("upload failed");
    }
  }
}
