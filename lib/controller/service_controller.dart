import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/services_Item.dart';

class ServiceController extends GetxController {
  var selectedService = Rxn<
      ServiceItem>(); //Rxn (Reactive Nullable) هو متغير تفاعلي يمكن أن يكون قيمته null، وهو جزء من نظام إدارة الحالة في GetX.
  void selecteService(ServiceItem servicesItem) {
    selectedService.value = servicesItem;
  }
}
  