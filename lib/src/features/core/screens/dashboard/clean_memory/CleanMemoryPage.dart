import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CleanMemoryPage extends StatelessWidget {
  const CleanMemoryPage({Key? key}) : super(key: key);

  // دالة لتنظيف الذاكرة (مسح الذاكرة المؤقتة)
  void cleanMemory(BuildContext context) async {
    await DefaultCacheManager().emptyCache();
    // إظهار رسالة تأكيد بعد تنظيف الذاكرة
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cache cleaned successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Memory'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // عرض زر لتنظيف الذاكرة
            ElevatedButton(
              onPressed: () => cleanMemory(context), // تمرير context إلى دالة تنظيف الذاكرة
              child: const Text('Clean Memory'),
            ),
            const SizedBox(height: 20),
            // يمكنك إضافة وصف للوظيفة هنا
            const Text(
              'Click the button above to clean the app\'s cache memory.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
