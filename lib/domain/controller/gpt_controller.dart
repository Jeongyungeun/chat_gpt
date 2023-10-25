import 'package:chat_gpt_clone/data/model/message_model/open_ai_model.dart';
import 'package:chat_gpt_clone/data/repository/gpt_future.dart';
import 'package:chat_gpt_clone/data/repository/gpt_repo.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class GptController extends GetxController{
  static GptController get to => Get.find(); 

  final GptChatConnection connection;

  GptController({required this.connection});

  RxList<Message> messages= <Message>[].obs;
  RxString inputText = ''.obs;

Future<void> requestChatGpt<GptRepoWithFuture>(String text)async{
  await connection.requestFutureGpt(text);
}



}