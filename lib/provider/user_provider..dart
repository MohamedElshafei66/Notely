import 'package:flutter/cupertino.dart';
import '../main.dart';

class UserDataProvider extends ChangeNotifier{
  String _username = "";
  String _email    = "";
  String? _imagePath;

  String get userName => _username;
  String get email    => _email;
  String? get imagePath => _imagePath;

  Future<void> loadDataUser(String email)async{
   _username  = shared.getString('username') ?? '';
   _email     = shared.getString('email')    ?? '';
   _imagePath = shared.getString('imagePath_$email');
   notifyListeners();
  }
  void setDataUser(String username , String email)async{
    _username = username;
    _email = email;
    await shared.setString('username', username);
    await shared.setString('email', email);
    notifyListeners();
  }
  Future<void> clearDataUser() async {
    await shared.remove('username');
    await shared.remove('email');
    _username = '';
    _email = '';
    _imagePath = null;
    notifyListeners();
  }
  void setImagePath(String email, String path) async {
    _imagePath = path;
    await shared.setString('imagePath_$email', path);
    notifyListeners();
  }
}
