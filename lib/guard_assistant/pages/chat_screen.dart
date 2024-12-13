import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/message.dart';
import '../models/messages.dart';
import '../utils/size.dart';
import '../utils/style.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _userMessage = TextEditingController();
  bool isLoading = false;
  bool showQuickQuestions = true;  // متغير لإظهار أو إخفاء الأسئلة السريعة

  static const apiKey = "AIzaSyAibcknltsi52JO5tq9FfYFsaW60RgRPeQ";

  final List<Message> _messages = [];

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  void sendMessage(String message) async {
    _userMessage.clear();

    setState(() {
      _messages.add(Message(
        isUser: true,
        message: message,
        date: DateTime.now(),
      ));
      isLoading = true;
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
        isUser: false,
        message: response.text ?? "",
        date: DateTime.now(),
      ));
    });
  }

  void onAnimatedTextFinished() {
    setState(() {
      isLoading = false;
    });
  }

  // قائمة الأسئلة السريعة
  final List<String> quickQuestions = [
    "Can viruses stop antivirus software?",
    "Can viruses infect mobile devices?",
    "How can I schedule a periodic scan of my device?",
    "What is the difference between viruses and malware?",
    "Can computer viruses slow down your computer?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text('Guard Assistant',
            style: GoogleFonts.poppins(color: white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: white),
          onPressed: () {
            Navigator.pop(context); // العودة للصفحة السابقة
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // عرض الرسائل في الشات
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                  onAnimatedTextFinished: onAnimatedTextFinished,
                );
              },
            ),
          ),

          // إذا كانت الأسئلة السريعة مرئية، نعرضها
          if (showQuickQuestions)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: quickQuestions.map((question) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        sendMessage(question);  // إرسال السؤال مباشرة
                        setState(() {
                          showQuickQuestions = false;  // إخفاء الأسئلة السريعة بعد الضغط
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // لون الزر
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        question,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          // شريط الإدخال لإرسال الرسائل
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: medium, vertical: small),
            child: Expanded(
              flex: 20,
              child: Row(
                children: [
                  // زر إظهار الأسئلة السريعة مرة أخرى
                  if (!showQuickQuestions)
                    IconButton(
                      icon: Icon(Icons.question_answer, color: white),
                      onPressed: () {
                        setState(() {
                          showQuickQuestions = true;  // إظهار الأسئلة السريعة عند الضغط
                        });
                      },
                    ),

                  Expanded(
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 1,
                      controller: _userMessage,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(medium, 0, small, 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(xlarge),
                        ),
                        hintText: 'Enter Your Question',
                        hintStyle: hintText,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (!isLoading && _userMessage.text.isNotEmpty) {
                              sendMessage(_userMessage.text); // إرسال الرسالة المكتوبة
                            }
                          },
                          child: isLoading
                              ? Container(
                            width: medium,
                            height: medium,
                            margin: const EdgeInsets.all(xsmall),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(white),
                              strokeWidth: 3,
                            ),
                          )
                              : Icon(
                            Icons.arrow_upward,
                            color: _userMessage.text.isNotEmpty
                                ? Colors.white
                                : const Color(0x5A6C6C65),
                          ),
                        ),
                      ),
                      style: promptText,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
