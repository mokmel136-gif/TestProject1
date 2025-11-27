import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BottomNavController extends GetxController {
  var currentIndex = 3.obs;
  void navagationPage(int index) {
    currentIndex.value = index;
  }
}
