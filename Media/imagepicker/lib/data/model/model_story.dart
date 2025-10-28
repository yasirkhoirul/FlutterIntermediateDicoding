import 'dart:convert';

class ModelStory {
  final bool error;
  final String message;

  ModelStory(this.error, this.message);

  factory ModelStory.frommap(Map<String, dynamic> data) {
    return ModelStory(data['error']??false, data['message']??'');
  }

  factory ModelStory.fromjson(String source){
    return ModelStory.frommap(jsonDecode(source));
  }
}
