import 'package:flutter/material.dart';
import '../../../../../../guard_assistant/pages/chat_screen.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/text_strings.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';

class DashboardBanners2 extends StatelessWidget {
  const DashboardBanners2({
    super.key,
    required this.txtTheme,
    required this.isDark,
  });

  final TextTheme txtTheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //1st banner
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      // انتقل إلى شاشة الـ ChatScreen عند الضغط على الزر
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatScreen()),
                      );
                    },
                    child: const Text('Guard Assistant'),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
