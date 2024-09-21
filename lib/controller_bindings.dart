import 'package:get/get.dart';
import 'package:scheduler/ui/utils/nav_bar_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NavBarController());
  }
}
