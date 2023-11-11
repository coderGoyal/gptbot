// ignore_for_file: library_private_types_in_public_api, camel_case_types, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: camel_case_types
class Gpt_flutter extends StatefulWidget {
  final String apiKey;

  const Gpt_flutter({Key? key, required this.apiKey}) : super(key: key);

  @override
  _Gpt_flutterState createState() => _Gpt_flutterState();
}

class _Gpt_flutterState extends State<Gpt_flutter> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    Message message = Message(text: _textEditingController.text, isMe: true);

    _textEditingController.clear();

    setState(() {
      _messages.insert(0, message);
    });

    String response = await messageTogpt(message.text);

    Message chatGpt = Message(text: response, isMe: false);

    setState(() {
      _messages.insert(0, chatGpt);
    });
  }

  Future<String> messageTogpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${widget.apiKey}",
      },
      body: json.encode(body),
    );

    print(response.body);

    Map<String, dynamic> parsedReponse = json.decode(response.body);

    String reply = parsedReponse['choices'][0]['message']['content'];

    return reply;
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 1.0.h),
        child: Column(
          crossAxisAlignment: message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? 'You' : 'GPT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: message.isMe ? Colors.blue : Colors.green,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.0.h),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.blue[100] : Colors.green[100],
                borderRadius: BorderRadius.circular(4.0.w),
              ),
              child: Text(
                message.text,
                style: TextStyle(fontSize: 4.0.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatGPT',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(2.0.w),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(2.0.h),
                        hintText: 'Type a message...',
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5.0.w),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: onSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
