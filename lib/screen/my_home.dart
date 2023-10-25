import 'dart:convert';

import 'package:chat_gpt_clone/commons/apikey.dart';
import 'package:chat_gpt_clone/commons/extension/duration.dart';
import 'package:chat_gpt_clone/data/model/chat_completion_model/chat_completion_model.dart';
import 'package:chat_gpt_clone/data/model/message_model/open_ai_model.dart';
import 'package:chat_gpt_clone/domain/controller/gpt_controller.dart';
import 'package:chat_gpt_clone/data/repository/gpt_future.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const String _kStrings = 'FastCampus Flutter ChatGPT';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TextEditingController messageTextController = TextEditingController();
  // final _historyList = List<Message>.empty(growable: true);
  String streamText = '';

  ScrollController scrollController = ScrollController();
  late Animation<int> _characterCount;
  late AnimationController animationController;

  setupAnimations() {
    animationController = AnimationController(vsync: this, duration: 2500.ms);
    _characterCount = StepTween(begin: 0, end: _currentString.length).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(1.seconds)
            .then((value) => animationController.reverse());
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(1.seconds)
            .then((value) => animationController.forward());
      }
    });
    animationController.forward();
  }

  // Future requestChat(String textMessage) async {
  //   ChatCompletionModel openAiModel = ChatCompletionModel(
  //       model: "gpt-3.5-turbo",
  //       messages: [
  //         Message(role: "system", content: 'You are a helpful assistant.'),
  //         ..._historyList,
  //       ],
  //       stream: false);
  //   final url = Uri.https("api.openai.com", "/v1/chat/completions");
  //   final resp = await http.post(url,
  //       headers: {
  //         "Authorization": "Bearer $apiKey",
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode(openAiModel.toJson()));
  //   debugPrint(resp.body);
  //   if (resp.statusCode == 200) {
  //     final jsonData = jsonDecode(utf8.decode(resp.bodyBytes)) as Map;
  //     String role = jsonData['choices'][0]["message"]['role'];
  //     String content = jsonData['choices'][0]['message']['content'];
  //     _historyList.last = _historyList.last.copyWith(
  //       role: role,
  //       content: content,
  //     );
  //     setState(() {
  //       _scrollDown();
  //     });
  //   }
  // }

  void _scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  Stream requestChatStream(String text) async* {
    ChatCompletionModel openAiModel = ChatCompletionModel(
      model: "gpt-3.5-turbo",
      messages: [
        Message(role: "system", content: 'You are a helpful assistant.'),
        ...GptController.to.messages,
      ],
      stream: true,
    );

    final url = Uri.https("api.openai.com", '/v1/chat/completions');
    final request = http.Request("POST", url)
      ..headers.addAll({
        "Authorization": "Bearer ${apiKey}",
        "Content-Type": 'application/json; charset=UTF-8',
        "Connection": "keep-alive",
        'Accept': "*/*",
        "Accept-Encoding": 'gzip, deflate, br',
      });
      request.body = jsonEncode(openAiModel.toJson());

      final resp = await http.Client().send(request);
      final byteStream = resp.stream.asyncExpand((event) => Rx.timer(event, 50.ms));
      final statusCode = resp.statusCode;
      String respText = '';

      await for(final byte in byteStream){
        var decode = utf8.decode(byte, allowMalformed: false);
        final strings = decode.split("data: ");
        for(final string in strings){
          final trimmedString = string.trim();
          if(trimmedString.isNotEmpty && !trimmedString.endsWith("[Done]")){
            final map = jsonDecode(trimmedString) as Map;
            final choices = map["choices"] as List;
            final delta = choices[0]["delta"] as Map;
            if(delta['content']!= null){
              final content = delta["content"] as String;
              respText += content;
              setState(() {
                streamText = respText;
              });
              yield content;
            }
          }
        }
      }
      if(respText.isNotEmpty){
        setState(() {

        });
      }
  }

  @override
  void initState() {
    setupAnimations();
    super.initState();
  }

  String get _currentString => MyHomePage._kStrings;

  @override
  void dispose() {
    messageTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future clearChat() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('새로운 대화의 시작'),
            content: Text('신규 대화를 생성하시겠어요?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      messageTextController.clear();
                      GptController.to.messages.clear();
                    });
                  },
                  child: Text('네'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Card(
                  child: PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: ListTile(
                        title: const Text('히스토리'),
                      )),
                      PopupMenuItem(
                          child: ListTile(
                        title: const Text('설정'),
                      )),
                      PopupMenuItem(
                          onTap: () {
                            clearChat();
                          },
                          child: ListTile(
                            title: const Text('새로운 채팅'),
                          )),
                    ];
                  }),
                ),
              ),
              Expanded(
                child: GptController.to.messages.isEmpty
                    ? Center(
                        child: AnimatedBuilder(
                          animation: _characterCount,
                          builder: (_, __) {
                            String text = _currentString.substring(
                                0, _characterCount.value);
                            return Row(
                              children: [
                                Text(
                                  text,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                CircleAvatar(
                                  radius: 8,
                                )
                              ],
                            );
                          },
                        ),
                      )
                    : GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: GptController.to.messages.length,
                          itemBuilder: (context, index) {
                            if (GptController.to.messages[index].role ==
                                "user") {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User'),
                                        Text(GptController
                                            .to.messages[index].content)
                                      ],
                                    ))
                                  ],
                                ),
                              );
                            }
                            return Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.teal,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ChatGPT"),
                                    Text(GptController
                                        .to.messages[index].content)
                                  ],
                                ))
                              ],
                            );
                          },
                        ),
                      ),
              ),
              Dismissible(
                key: Key("chat-bar"),
                direction: DismissDirection.startToEnd,
                onDismissed: (d) {
                  if (d == DismissDirection.startToEnd) {
                    // logic
                  }
                },
                background: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('New Chat'),
                  ],
                ),
                confirmDismiss: (d) async {
                  if (d == DismissDirection.startToEnd) {
                    //logic
                    if (GptController.to.messages.isEmpty) return;
                    clearChat();
                  }
                  return null;
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all()),
                        child: TextField(
                          controller: messageTextController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Message'),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 42,
                      onPressed: () async {
                        if (messageTextController.text.isEmpty) {
                          return;
                        }
                        GptController.to.messages.add(
                          Message(
                              content: messageTextController.text.trim(),
                              role: "user"),
                        );
                        GptController.to.messages
                            .add(Message(content: "", role: "assistant"));

                        try {
                          var text = "";
                          final stream = requestChatStream(messageTextController.text.trim());
                          await for (final textChunk in stream){
                            text += textChunk;
                            setState(() {
                              GptController.to.messages.last = GptController.to.messages.last.copyWith(content: text);
                            _scrollDown();
                            });
                          }
                          // await GptController.to
                          //     .requestChatGpt(messageTextController.text.trim());
                          messageTextController.clear();
                          streamText = '';
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      icon: Icon(Icons.arrow_circle_up),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
