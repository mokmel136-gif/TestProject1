
import 'package:get/get.dart';

class ConttPass extends GetxController{
  bool pass = true;

  void isPassword(){
    pass =! pass;
    update();
  }


}