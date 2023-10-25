import 'package:chat_gpt_clone/domain/controller/gpt_controller.dart';
import 'package:chat_gpt_clone/data/repository/gpt_future.dart';
import 'package:get/instance_manager.dart';

class ChatGptBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<GptController>(GptController(connection: GptRepoWithFutureImpl()));
  }

}