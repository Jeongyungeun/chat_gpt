// Message
// ChatCompletionModel
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_ai_model.freezed.dart';
part 'open_ai_model.g.dart';

@freezed
class Message with _$Message {

  factory Message(
    {
      required String content,
      String? role,
    }
  ) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}