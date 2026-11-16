
// import 'package:flutter/material.dart';
// import 'package:shop_easy/thehoso.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: TheHoSo());
//   }
// }
// bài khác
// lib/main.dart
// lib/main.dart
// import 'package:flutter/material.dart';
// import 'app_settings.dart';
// import 'thehoso.dart'; // Import màn hình Thẻ Hồ sơ (Profile)
// import 'screens/login_screen.dart';
// import 'screens/register_screen.dart';
// import 'screens/forgot_password_screen.dart';
// import 'screens/settings_screen.dart';
// import 'screens/product_list_screen.dart';
// import 'screens/dashboard_screen.dart'; // GD 11: Tổng quan
// import 'screens/cart_screen.dart';      // GD 8: Giỏ hàng

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: AppSettings.instance,
//       builder: (context, child) {
//         final settings = AppSettings.instance;

//         return MaterialApp(
//           title: 'ShopEasy',
//           debugShowCheckedModeBanner: false,
//           themeMode: settings.themeMode,
//           theme: ThemeData(
//             brightness: Brightness.light,
//             colorScheme: ColorScheme.fromSeed(
//               seedColor: const Color(0xFF1E3A8A),
//               brightness: Brightness.light,
//             ),
//             useMaterial3: true,
//           ),
//           darkTheme: ThemeData(
//             brightness: Brightness.dark,
//             colorScheme: ColorScheme.fromSeed(
//               seedColor: const Color(0xFF1E3A8A),
//               brightness: Brightness.dark,
//             ),
//             useMaterial3: true,
//           ),
//           builder: (context, widget) {
//             return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 textScaler: TextScaler.linear(settings.textScaleFactor),
//               ),
//               child: widget!,
//             );
//           },
//           initialRoute: '/login',
//           routes: {
//             '/login': (context) => const LoginScreen(),
//             '/register': (context) => const RegisterScreen(),
//             '/forgot-password': (context) => const ForgotPasswordScreen(),
//             '/dashboard': (context) => const DashboardScreen(),  // GD 11
//             '/products': (context) => const ProductListScreen(),  // GD 6
//             '/cart': (context) => const CartScreen(),            // GD 8
//             '/settings': (context) => const SettingsScreen(),      // GD 4
//             '/profile': (context) => const TheHoSo(),            // Hồ sơ cá nhân
//           },
//         );
//       },
//     );
//   }
// }
// file main tổng 
import 'package:flutter/material.dart';
import 'app_settings.dart';
import 'counter.dart';
import 'home_page.dart';
import 'plance.dart';
import 'slider.dart';
import 'student.dart';
import 'thehoso.dart';

// Import các màn hình dự án ShopEasy
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, child) {
        final settings = AppSettings.instance;

        return MaterialApp(
          title: 'Danh Sách Bài Tập Flutter',
          debugShowCheckedModeBanner: false,
          locale: Locale(settings.languageCode),
          themeMode: settings.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E3A8A),
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E3A8A),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          // Giữ đồng bộ cỡ chữ cho toàn bộ ShopEasy
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(settings.textScaleFactor),
              ),
              child: widget!,
            );
          },
          initialRoute: '/',
          routes: {
            '/': (context) => const ExerciseMenuScreen(),
            '/counter': (context) => const MyCounter(),
            '/home_page': (context) => const HomePage(),
            '/plance': (context) => const plancePage(),
            '/slider': (context) => const SliderPage(),
            '/student': (context) => const Student(),
            '/profile': (context) => const TheHoSo(),

            // Routes cho ShopEasy
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/forgot-password': (context) => const ForgotPasswordScreen(),
            '/dashboard': (context) => const DashboardScreen(),
            '/products': (context) => const ProductListScreen(),
            '/cart': (context) => const CartScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}

class _ExerciseItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  const _ExerciseItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });
}

class ExerciseMenuScreen extends StatelessWidget {
  const ExerciseMenuScreen({super.key});

  static const _exercises = [
    _ExerciseItem(
      title: '1. Bộ đếm & Thẻ sinh viên',
      subtitle: 'counter.dart · Tăng/giảm đếm & Thông tin sinh viên',
      icon: Icons.add_circle_outline,
      color: Colors.blue,
      route: '/counter',
    ),
    _ExerciseItem(
      title: '2. Thực hành Widget',
      subtitle: 'home_page.dart · AppBar, Hình ảnh & Thông tin',
      icon: Icons.widgets_outlined,
      color: Colors.indigo,
      route: '/home_page',
    ),
    _ExerciseItem(
      title: '3. Chi tiết địa điểm Vancouver',
      subtitle: 'plance.dart · Bố cục hình ảnh, Nút tương tác & Mô tả',
      icon: Icons.place_outlined,
      color: Colors.teal,
      route: '/plance',
    ),
    _ExerciseItem(
      title: '4. Trình chiếu ảnh Carousel',
      subtitle: 'slider.dart · PageView slider hiệu ứng mờ',
      icon: Icons.view_carousel_outlined,
      color: Colors.orange,
      route: '/slider',
    ),
    _ExerciseItem(
      title: '5. Nhập liệu sinh viên',
      subtitle: 'student.dart · TextField tương tác & Xem họ tên',
      icon: Icons.person_search_outlined,
      color: Colors.purple,
      route: '/student',
    ),
    _ExerciseItem(
      title: '6. Thẻ hồ sơ cá nhân',
      subtitle: 'thehoso.dart · Card Hồ sơ, Avatar & Số liệu thống kê',
      icon: Icons.badge_outlined,
      color: Colors.green,
      route: '/profile',
    ),
    _ExerciseItem(
      title: '7. Trang Đăng nhập (ShopEasy)',
      subtitle: 'screens/login_screen.dart · Cổng đăng nhập liên kết toàn bộ màn hình',
      icon: Icons.lock_outline,
      color: Colors.redAccent,
      route: '/login',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Bài Tập Flutter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            tooltip: 'Đổi Chế Độ Sáng/Tối',
            onPressed: () {
              settings.toggleDarkMode(!settings.isDarkMode);
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _exercises.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _exercises[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: item.color.withOpacity(0.15),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 26,
                ),
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  item.subtitle,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, item.route);
              },
            ),
          );
        },
      ),
    );
  }
}