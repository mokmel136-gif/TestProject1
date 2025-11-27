import 'package:get/get.dart';
import '../services_ِapi/api_service.dart';
import '../models/user.model.dart';
import 'GetSto.dart'; // AuthUser

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final AuthUser authUser = AuthUser(); //  ربط مع التخزين المحلي

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    //  تحقق إذا في بيانات مخزنة محلياً
    authUser.inti();
    if (authUser.isLogin.value && authUser.authUser != null) {
      currentUser.value = authUser.authUser;
      isLoggedIn.value = true;
    } else {
      checkAuthStatus();
    }
  }

  /// تحقق من حالة تسجيل الدخول
  Future<void> checkAuthStatus() async {
    final token = await _apiService.getToken();
    if (token != null) {
      await getCurrentUser();
    } else {
      isLoggedIn.value = false;
    }
  }

  ///  تسجيل مستخدم جديد
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final response = await _apiService.register(
        name: name,
        email: email,
        password: password,
      );

      if (response["success"]) {
        final user = UserModel.fromJson(response["data"]["user"]);
        currentUser.value = user;
        isLoggedIn.value = true;

        //  حفظ بيانات المستخدم محلياً
        authUser.saveUser(user);

        Get.snackbar("نجاح", response["message"]);
        Get.offAllNamed("/home");
      } else {
        Get.snackbar("خطأ", response["message"]);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء التسجيل");
    } finally {
      isLoading.value = false;
    }
  }

  ///  تسجيل الدخول
  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final response = await _apiService.login(
        email: email,
        password: password,
      );

      if (response["success"]) {
        final user = UserModel.fromJson(response["data"]["user"]);
        currentUser.value = user;
        isLoggedIn.value = true;

        //  حفظ بيانات المستخدم محلياً
        authUser.saveUser(user);

        Get.snackbar("نجاح", response["message"]);
        Get.offAllNamed("/home");
      } else {
        Get.snackbar("خطأ", response["message"]);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء تسجيل الدخول");
    } finally {
      isLoading.value = false;
    }
  }

  ///  تسجيل الخروج
  Future<void> logout() async {
    try {
      await _apiService.logout(); // (اختياري إذا عندك API logout)
      await _apiService.removeToken(); // امسح التوكن من التخزين
      authUser.logOut(); //  امسح بيانات المستخدم نهائياً

      currentUser.value = null;
      isLoggedIn.value = false;

      Get.offAllNamed("/login");
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء تسجيل الخروج");
    }
  }

  /// جلب بيانات المستخدم الحالي
  Future<void> getCurrentUser() async {
    try {
      final response = await _apiService.getUser();

      if (response["success"]) {
        final user = UserModel.fromJson(response["data"]);
        currentUser.value = user;
        isLoggedIn.value = true;

        //  تحديث البيانات المخزنة
        authUser.saveUser(user);
      }
    } catch (e) {
      await _apiService.removeToken();
      authUser.logOut();
      isLoggedIn.value = false;
    }
  }
}
     