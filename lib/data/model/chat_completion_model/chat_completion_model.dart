
import 'package:chat_gpt_clone/data/model/message_model/open_ai_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completion_model.freezed.dart';
part 'chat_completion_model.g.dart';


@freezed
class ChatCompletionModel with _$ChatCompletionModel {

  factory ChatCompletionModel(
    {
      required String model,
      required List<Message> messages,
      required bool stream,

    }
  ) = _ChatCompletionModel;

  factory ChatCompletionModel.fromJson(Map<String, dynamic> json) => _$ChatCompletionModelFromJson(json);
}

