import 'package:get/get.dart';
import 'package:shared_preference/controller/network_controller.dart';

class DependencyInjection{

  static void init(){
    Get.put<NetworkController>(NetworkController(), permanent: true);
    
  }
}