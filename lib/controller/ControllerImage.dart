import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app1/controller/GetSto.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();

  Rxn<File> image = Rxn<File>(); // الصورة الحالية للمستخدم
  RxBool isDarkMode = false.obs; // مثال لوضع داكن/فاتح

  // تحميل الصورة من التخزين عند البداية
  @override
  void onInit() {
    super.onInit();
    final auth = AuthUser();
    final email = auth.authUser?.email;
    if (email != null) {
      String? path = box.read('userImage_$email');
      if (path != null && path.isNotEmpty) {
        image.value = File(path);
      }
    }
  }

  // طلب الأذونات
  Future<void> _requestPermission() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  // اختيار صورة من المعرض
  Future<void> pickImage(String email) async {
    await _requestPermission();
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      image.value = File(picked.path);
      // حفظ الصورة في GetStorage باسم يعتمد على البريد الإلكتروني
      box.write('userImage_$email', picked.path);
    }
  }

}
