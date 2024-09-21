import 'package:get/get.dart';

class NavBarController extends GetxController {
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    update();
  }
}
