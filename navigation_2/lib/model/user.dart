import 'dart:convert';

class User {
  final String username;
  final String password;
  User({required this.username, required this.password});
  @override
  String toString() {
    // unttuk debugging lebih mudah
    return 'User(username: $username, password: $password)';
  }

  factory User.fromjson(String source)=> jsonDecode(source);
  // String jsonString = '{"name": "Ravi", "age": 21}';
  // var data = jsonDecode(jsonString);
  // print(data['name']); // Output: Ravi
  factory User.frommap(Map<String, dynamic> json) {
    return User(username: json['username'], password: json['password']);
  }

  String tojson()=> jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }

  bool operator ==(Object other){
    if (identical(this, other)) return true;
    return other is User && other.username == username  && other.password == password;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(username, password);
}
