import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/widgets/appbar.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/widgets/banners.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/widgets/categories2.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../profile/update_profile_screen.dart';
import 'about/about.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String scanResultMessage = ''; // لتخزين الرسالة من السيرفر

  // دالة لتحميل الملف إلى الخادم
  Future<void> uploadFile(File file) async {
    var uri = Uri.parse('http://16.170.214.35:5000/scan');  // عنوان API الخاص بالخادم السحابي

    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType('application', 'octet-stream'),
      ));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var result = await http.Response.fromStream(response);
        // إذا كانت النتيجة تحتوي على "infected" نعرض الفيروس
        if (result.body.contains('infected')) {
          setState(() {
            scanResultMessage = 'File is infected: ${result.body.split(":")[1]}';
          });
        } else {
          setState(() {
            scanResultMessage = 'File is clean!';
          });
        }

        // اختفاء الرسالة بعد دقيقة
        Future.delayed(const Duration(seconds: 60), () {
          setState(() {
            scanResultMessage = ''; // إخفاء الرسالة
          });
        });
      } else {
        Get.snackbar('Error', 'Error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  // دالة لاختيار الملف من الجهاز
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      await uploadFile(file);
    } else {
      // إذا لم يتم اختيار أي ملف
      Get.snackbar('No File', 'No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark; //Dark mode

    return Scaffold(
      appBar: DashboardAppBar(isDark: isDark),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: Image(image: AssetImage(tLogoImage)),
              currentAccountPictureSize: Size(100, 100),
              accountName: Text('Secure Guard'),
              accountEmail: Text('support@secureguard.com'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Account information'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Application'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Get.defaultDialog(
                  title: "LOGOUT",
                  titleStyle: const TextStyle(fontSize: 20),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("Are you sure, you want to Logout?"),
                  ),
                  confirm: TextButton(
                    onPressed: () {
                      AuthenticationRepository.instance.logout();
                      Get.back();
                    },
                    child: const Text("Yes"),
                  ),
                  cancel: SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("No"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),


      body: SingleChildScrollView(

        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // لجعل العناصر في المنتصف

            children: [
              Text('Dashboard', style: Theme.of(context).textTheme.bodyLarge),
              const Text('Virus Scan', style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
              const SizedBox(height: 70), // زيادة المسافة بين النص والدائرة

              // الدائرة التي تحتوي على Scan File
              GestureDetector(
                onTap: pickFile,  // لاختيار الملف عند الضغط على الدائرة
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(4, 4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 90,  // تقليل حجم الدائرة
                    child: Text(
                      'Select File',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22, // تقليل حجم النص
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // مسافة إضافية قبل الرسالة

              // عرض رسالة النتيجة إذا كانت موجودة
              if (scanResultMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    scanResultMessage,
                    style: TextStyle(
                      fontSize: 16,
                      color: scanResultMessage.contains('infected') ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              const SizedBox(height: 100),

              DashboardBanners(txtTheme: txtTheme, isDark: isDark),
              const SizedBox(height: tDashboardPadding),

              DashboardBanners2(txtTheme: txtTheme, isDark: isDark),
              const SizedBox(height: tDashboardPadding),

            ],
          ),
        ),
      ),
    );
  }
}
