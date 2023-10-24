// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_completion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatCompletionModel _$ChatCompletionModelFromJson(Map<String, dynamic> json) {
  return _ChatCompletionModel.fromJson(json);
}

/// @nodoc
mixin _$ChatCompletionModel {
  String get model => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  bool get stream => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCompletionModelCopyWith<ChatCompletionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCompletionModelCopyWith<$Res> {
  factory $ChatCompletionModelCopyWith(
          ChatCompletionModel value, $Res Function(ChatCompletionModel) then) =
      _$ChatCompletionModelCopyWithImpl<$Res, ChatCompletionModel>;
  @useResult
  $Res call({String model, List<Message> messages, bool stream});
}

/// @nodoc
class _$ChatCompletionModelCopyWithImpl<$Res, $Val extends ChatCompletionModel>
    implements $ChatCompletionModelCopyWith<$Res> {
  _$ChatCompletionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? messages = null,
    Object? stream = null,
  }) {
    return _then(_value.copyWith(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      stream: null == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatCompletionModelImplCopyWith<$Res>
    implements $ChatCompletionModelCopyWith<$Res> {
  factory _$$ChatCompletionModelImplCopyWith(_$ChatCompletionModelImpl value,
          $Res Function(_$ChatCompletionModelImpl) then) =
      __$$ChatCompletionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String model, List<Message> messages, bool stream});
}

/// @nodoc
class __$$ChatCompletionModelImplCopyWithImpl<$Res>
    extends _$ChatCompletionModelCopyWithImpl<$Res, _$ChatCompletionModelImpl>
    implements _$$ChatCompletionModelImplCopyWith<$Res> {
  __$$ChatCompletionModelImplCopyWithImpl(_$ChatCompletionModelImpl _value,
      $Res Function(_$ChatCompletionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? messages = null,
    Object? stream = null,
  }) {
    return _then(_$ChatCompletionModelImpl(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      stream: null == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatCompletionModelImpl implements _ChatCompletionModel {
  _$ChatCompletionModelImpl(
      {required this.model,
      required final List<Message> messages,
      required this.stream})
      : _messages = messages;

  factory _$ChatCompletionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatCompletionModelImplFromJson(json);

  @override
  final String model;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final bool stream;

  @override
  String toString() {
    return 'ChatCompletionModel(model: $model, messages: $messages, stream: $stream)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatCompletionModelImpl &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, model,
      const DeepCollectionEquality().hash(_messages), stream);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatCompletionModelImplCopyWith<_$ChatCompletionModelImpl> get copyWith =>
      __$$ChatCompletionModelImplCopyWithImpl<_$ChatCompletionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatCompletionModelImplToJson(
      this,
    );
  }
}

abstract class _ChatCompletionModel implements ChatCompletionModel {
  factory _ChatCompletionModel(
      {required final String model,
      required final List<Message> messages,
      required final bool stream}) = _$ChatCompletionModelImpl;

  factory _ChatCompletionModel.fromJson(Map<String, dynamic> json) =
      _$ChatCompletionModelImpl.fromJson;

  @override
  String get model;
  @override
  List<Message> get messages;
  @override
  bool get stream;
  @override
  @JsonKey(ignore: true)
  _$$ChatCompletionModelImplCopyWith<_$ChatCompletionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
