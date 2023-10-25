// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_completion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatCompletionModelImpl _$$ChatCompletionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatCompletionModelImpl(
      model: json['model'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      stream: json['stream'] as bool,
    );

Map<String, dynamic> _$$ChatCompletionModelImplToJson(
        _$ChatCompletionModelImpl instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages,
      'stream': instance.stream,
    };
