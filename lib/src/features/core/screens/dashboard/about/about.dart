import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Secure Guard'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the page
            Text(
              'About Secure Guard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),

            // App description
            Text(
              'Secure Guard is a powerful antivirus application that provides comprehensive protection for your device from digital threats. By utilizing the latest virus detection and malware technology, the app helps you keep your privacy and data safe from harmful programs and various threats.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Why Secure Guard section
            Text(
              'Why Secure Guard?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'In today\'s digital world, online security threats are more sophisticated and widespread than ever before. With the increasing use of mobile devices, Android devices have become a primary target for viruses, malware, and malicious software. Secure Guard offers you reliable solutions to protect against these threats:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Features list
            Text(
              '- Advanced virus detection: The app relies on a powerful engine to detect viruses.\n'
                  '- Real-time protection: The app provides continuous protection.\n'
                  '- App and file scanning: You can scan any app or file before opening or installing it.\n'
                  '- Memory cleaning and speed-up: The app helps clean your device\'s memory.\n'
                  '- Easy-to-use interface: The app features a simple user interface.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // How Secure Guard works section
            Text(
              'How does Secure Guard work?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Secure Guard regularly scans all apps installed on your device.\n'
                  '• When a new app is installed or a file is downloaded, the app scans for viruses immediately.\n'
                  '• If a virus or harmful program is detected, Secure Guard isolates it to protect you.\n'
                  '• The app also allows you to clean up memory to improve device performance and speed.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Security paragraph
            Text(
              'Your device\'s security is in safe hands with Secure Guard!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'With its advanced security features, Secure Guard ensures that users can enjoy a safe and secure browsing experience. Don\'t let viruses compromise your device—install Secure Guard today to protect your device from all digital threats.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Support contact section
            Text(
              'Have any questions?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Chat with Guard Chat or \ncontact our support team via email: support@secureguard.com',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
