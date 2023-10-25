import 'dart:convert';

import 'package:chat_gpt_clone/commons/apikey.dart';
import 'package:chat_gpt_clone/data/model/chat_completion_model/chat_completion_model.dart';
import 'package:chat_gpt_clone/data/model/message_model/open_ai_model.dart';
import 'package:chat_gpt_clone/domain/controller/gpt_controller.dart';
import 'package:chat_gpt_clone/data/repository/gpt_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart'as http;

class GptRepoWithFutureImpl implements GptChatConnection{


  @override
  Future<void> requestFutureGpt(String text, [void Function()? callback]) async{
    ChatCompletionModel openAiModel = ChatCompletionModel(
        model: "gpt-3.5-turbo",
        messages: [
          Message(role: "system", content: 'You are a helpful assistant.'),
          ...GptController.to.messages,
        ],
        stream: false);
    http.Response resp = await requestGptAddress(openAiModel);
        if (resp.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(resp.bodyBytes)) as Map;
      String role = jsonData['choices'][0]["message"]['role'];
      String content = jsonData['choices'][0]['message']['content'];
      GptController.to.messages.last = GptController.to.messages.last.copyWith(
        role: role,
        content: content,
      );
      callback;
    }
  }

  Future<http.Response> requestGptAddress(ChatCompletionModel openAiModel) async {
    final url = Uri.https("api.openai.com", "/v1/chat/completions");
    final resp = await http.post(url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode(openAiModel.toJson()));
    return resp;
  }

}