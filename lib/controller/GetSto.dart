import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:my_app1/models/user.model.dart';

class AuthUser {
  final box = GetStorage();
  static String keyStorage = 'authUser';
  static String keyLogin = 'isLogin';
  UserModel? authUser;
  var isLogin = false.obs;

  static final AuthUser _singleton = AuthUser._internal();

  factory AuthUser() {
    return _singleton;
  }

  AuthUser._internal();

  void inti() {
    final dataUser = box.read(keyStorage);
    final loggedIn = box.read(keyLogin) ?? false;
    if (dataUser != null && loggedIn) {
      authUser = UserModel.fromJson(dataUser);
      isLogin.value = true;
    } else {
      authUser = null;
      isLogin.value = false;
    }
  }

  void saveUser(UserModel user) {
    box.write(keyStorage, user.toJson());
    box.write(keyLogin, true);
    authUser = user;
    isLogin.value = true;
  }

  void logOut() {
    box.erase(); //  يمسح كل البيانات المخزنة في GetStorage
    authUser = null;
    isLogin.value = false;
  }

  UserModel? getUser() {
    final dataUser = box.read(keyStorage);
    if (dataUser != null) {
      return UserModel.fromJson(dataUser);
    }
    return null;
  }
}
