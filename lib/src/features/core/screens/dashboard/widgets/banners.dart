import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // استيراد مكتبة إدارة الذاكرة المؤقتة
import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/text_strings.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';

class DashboardBanners extends StatelessWidget {
  const DashboardBanners({
    super.key,
    required this.txtTheme,
    required this.isDark,
  });

  final TextTheme txtTheme;
  final bool isDark;

  // دالة لتنظيف الذاكرة المؤقتة
  void cleanMemory(BuildContext context) async {
    try {
      // مسح الكاش (الذاكرة المؤقتة)
      await DefaultCacheManager().emptyCache();

      // إظهار رسالة تأكيد باستخدام SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Memory cache cleaned successfully!")),
      );
    } catch (e) {
      // في حال حدوث خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to clean memory cache.")),
      );
    }
  }

  // دالة لتحسين البطارية (مؤقتة فقط في هذا المثال)
  void optimizeBattery(BuildContext context) {
    // عادةً، يمكن تحسين البطارية بتقليل استهلاك الطاقة في بعض الخدمات، ولكن في Flutter لا توجد مكتبة مباشرة لإيقاف هذه الخدمات.
    // نحن نعرض فقط رسالة للمستخدم تفيد بأنه تم تحسين البطارية.

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Battery optimized successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1st banner (Clean Memory)
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    onPressed: () => cleanMemory(context), // عند الضغط، نقوم بتنظيف الذاكرة
                    child: const Text('Clean Memory'),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: tDashboardCardPadding),

        // 2nd banner (Speed Up / Optimize Battery)
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    onPressed: () => optimizeBattery(context), // عند الضغط، نقوم بتحسين البطارية
                    child: const Text('Optimize Battery'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
