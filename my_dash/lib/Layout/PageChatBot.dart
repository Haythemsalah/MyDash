
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_dash/Naviguation%20menu/PageMenu.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class Page4 extends StatefulWidget {
  @override
  Page4State createState() => Page4State();
}

class Page4State extends State<Page4> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print('Speech Recognition Status: $status');
      },
      onError: (errorNotification) {
        print('Speech Recognition Error: $errorNotification');
      },
    );

    if (available) {
      print('Speech Recognition is available.');
    } else {
      print('Speech Recognition is not available.');
    }
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({"text": message, "isUser": true});
    });
    final response = await http.post(
      Uri.parse('https://chatbot-api-rpgu.onrender.com/api/chatbot'),
      body: json.encode({"message": message}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _messages.add({"text": data['response'], "isUser": false});
      });
    } else {
      throw Exception('Failed to load response');
    }
  }

  void startListening() {
    setState(() {
      _isListening = true;
    });
    _speech.listen(
      onResult: (result) {
        setState(() {
          _controller.text = result.recognizedWords;
        });
      },
    );
  }

  void stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Orange Chat App DATA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            backgroundColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 15, 19, 21) : Colors.white,
          ),
          body: Container(
            color: themeProvider.isDarkMode ? const Color.fromARGB(255, 15, 19, 21) : Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Align(
                        alignment: _messages[index]["isUser"]
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: _messages[index]["isUser"]
                                ? Colors.blue
                                : (themeProvider.isDarkMode
                                    ? Colors.black
                                    : const Color.fromARGB(223, 255, 115, 34)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            _messages[index]["text"],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
  child: TextField(
    controller: _controller,
    style: TextStyle(
      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
    ),
    decoration: InputDecoration(
      hintText: 'Enter your message...',
      hintStyle: TextStyle(
        color: themeProvider.isDarkMode ? Colors.white54 : Colors.black54,
      ),
    ),
  ),
),
                      IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: _isListening
                            ? stopListening
                            : startListening,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          String message = _controller.text.trim();
                          if (message.isNotEmpty) {
                            _sendMessage(message);
                            _controller.clear();
                          }
                        },
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}