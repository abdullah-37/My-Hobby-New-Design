// lib/controller/floating_button_controller.dart
import 'package:get/get.dart';

class FloatingButtonController extends GetxController {
  RxBool isVisible = true.obs;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  void hide() => isVisible.value = false;

  void show() => isVisible.value = true;
}
