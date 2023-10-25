
abstract interface class GptChatConnection {
  Future<void> requestFutureGpt(String text, [void Function() callback]);
}