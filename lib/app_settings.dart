// lib/app_settings.dart
import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings instance = AppSettings._();

  // 1. Giao diện Sáng / Tối
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleDarkMode(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // 2. Tài khoản (Thông báo & Nhớ đăng nhập)
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;
  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  bool _rememberLogin = true;
  bool get rememberLogin => _rememberLogin;
  void toggleRememberLogin(bool value) {
    _rememberLogin = value;
    notifyListeners();
  }

  // 3. Cỡ chữ toàn ứng dụng (0.85: Nhỏ, 1.0: Vừa, 1.2: Lớn)
  double _textScaleFactor = 1.0;
  double get textScaleFactor => _textScaleFactor;

  void setTextScale(double scale) {
    _textScaleFactor = scale;
    notifyListeners();
  }

  String get fontSizeLabel {
    if (_textScaleFactor < 0.95) return t('size_small');
    if (_textScaleFactor > 1.05) return t('size_large');
    return t('size_medium');
  }

  // 4. Ngôn ngữ toàn ứng dụng ('vi' hoặc 'en')
  String _languageCode = 'vi';
  String get languageCode => _languageCode;
  bool get isVietnamese => _languageCode == 'vi';

  void setLanguage(String code) {
    if (_languageCode == code) return;
    _languageCode = code;
    notifyListeners();
  }

  String get languageLabel => isVietnamese ? 'Tiếng Việt' : 'English';

  // Hỗ trợ gọi cả settings.t(...) và settings.tr(...) trên toàn ứng dụng
  String t(String key) {
    return _localizedStrings[_languageCode]?[key] ??
        _localizedStrings['vi']?[key] ??
        key;
  }

  String tr(String key) => t(key);

  static const Map<String, Map<String, String>> _localizedStrings = {
    'vi': {
      // Xác thực (Login / Register / Forgot Password)
      'login': 'Đăng nhập',
      'register': 'Đăng ký',
      'forgotPassword': 'Quên mật khẩu?',
      'forgot_password': 'Quên mật khẩu',
      'email': 'Email',
      'password': 'Mật khẩu',
      'confirmPassword': 'Xác nhận mật khẩu',
      'fullName': 'Họ và tên',
      'phone': 'Số điện thoại',
      'noAccount': 'Chưa có tài khoản?',
      'haveAccount': 'Đã có tài khoản?',
      'sendRequest': 'Gửi yêu cầu',
      'backToLogin': 'Quay lại đăng nhập',

      // Cài đặt (Settings)
      'settings': 'Cài đặt',
      'account_section': 'TÀI KHOẢN',
      'notifications': 'Nhận thông báo',
      'dark_mode': 'Chế độ tối',
      'remember_login': 'Nhớ đăng nhập',
      'app_section': 'ỨNG DỤNG',
      'language': 'Ngôn ngữ',
      'font_size': 'Cỡ chữ',
      'about_app': 'Về ứng dụng',
      'about_desc': 'Ứng dụng thương mại điện tử ShopEasy · Phiên bản 1.0.0',
      'profile': 'Profile',
      'logout': 'Đăng xuất',
      'choose_language': 'Chọn ngôn ngữ',
      'choose_font_size': 'Chọn cỡ chữ',
      'size_small': 'Nhỏ',
      'size_medium': 'Vừa',
      'size_large': 'Lớn',
      'close': 'Đóng',

      // Danh sách, Giỏ hàng & Chi tiết sản phẩm
      'search_tooltip': 'Tìm kiếm',
      'cart_tooltip': 'Giỏ hàng',
      'cart': 'Giỏ hàng',
      'checkout': 'Thanh toán',
      'total': 'Tổng cộng',
      'search_hint': 'Tìm sản phẩm...',
      'cat_all': 'Tất cả',
      'cat_phone': 'Điện thoại',
      'cat_laptop': 'Laptop',
      'cat_watch': 'Đồng hồ',
      'cat_accessory': 'Phụ kiện',
      'no_products': 'Không tìm thấy sản phẩm nào',
      'add_to_cart': 'Thêm vào giỏ',
      'added_to_cart': 'Đã thêm vào giỏ hàng!',
      'buy_now': 'Mua ngay',
      'go_checkout': 'Chuyển tới trang thanh toán!',
      'reviews': 'đánh giá',
      'product_desc_title': 'Mô tả sản phẩm',
      'product_desc_body':
          'Sản phẩm chính hãng với thiết kế sang trọng, hiện đại và cấu hình vô cùng mạnh mẽ. Đáp ứng tốt mọi nhu cầu giải trí, làm việc đỉnh cao và khả năng tiết kiệm năng lượng tối ưu.',
      'see_more': 'Xem thêm ▼',
      'collapse': 'Thu gọn ▲',

      // Thanh điều hướng & Tổng quát (Dashboard)
      'nav_products': 'Sản phẩm',
      'nav_dashboard': 'Tổng quát',
      'nav_settings': 'Cài đặt',
      'dashboard_title': 'Tổng quan',
      'stat_orders': 'Đơn hàng',
      'stat_revenue': 'Doanh thu',
      'stat_customers': 'Khách hàng',
      'stat_products': 'Sản phẩm',
      'recent_orders': 'Đơn hàng gần đây',
      'view_all': 'Xem tất cả',
      'status_completed': 'Hoàn thành',
      'status_processing': 'Đang xử lý',
      'status_shipping': 'Đang giao',
      'status_cancelled': 'Đã hủy',
    },
    'en': {
      // Authentication
      'login': 'Login',
      'register': 'Register',
      'forgotPassword': 'Forgot password?',
      'forgot_password': 'Forgot Password',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm password',
      'fullName': 'Full name',
      'phone': 'Phone number',
      'noAccount': 'Don\'t have an account?',
      'haveAccount': 'Already have an account?',
      'sendRequest': 'Send request',
      'backToLogin': 'Back to login',

      // Settings
      'settings': 'Settings',
      'account_section': 'ACCOUNT',
      'notifications': 'Notifications',
      'dark_mode': 'Dark mode',
      'remember_login': 'Remember login',
      'app_section': 'APPLICATION',
      'language': 'Language',
      'font_size': 'Font size',
      'about_app': 'About app',
      'about_desc': 'ShopEasy E-Commerce App · Version 1.0.0',
      'profile': 'Profile',
      'logout': 'Log out',
      'choose_language': 'Select language',
      'choose_font_size': 'Select font size',
      'size_small': 'Small',
      'size_medium': 'Medium',
      'size_large': 'Large',
      'close': 'Close',

      // Product List, Cart & Detail
      'search_tooltip': 'Search',
      'cart_tooltip': 'Cart',
      'cart': 'Shopping Cart',
      'checkout': 'Checkout',
      'total': 'Total',
      'search_hint': 'Search products...',
      'cat_all': 'All',
      'cat_phone': 'Phones',
      'cat_laptop': 'Laptops',
      'cat_watch': 'Watches',
      'cat_accessory': 'Accessories',
      'no_products': 'No products found',
      'add_to_cart': 'Add to cart',
      'added_to_cart': 'Added to cart!',
      'buy_now': 'Buy now',
      'go_checkout': 'Proceeding to checkout!',
      'reviews': 'reviews',
      'product_desc_title': 'Product Description',
      'product_desc_body':
          'Genuine product with a sleek, modern design and powerful hardware performance. Built to handle entertainment, demanding work, and optimal battery efficiency.',
      'see_more': 'See more ▼',
      'collapse': 'Collapse ▲',

      // Navigation & Dashboard
      'nav_products': 'Products',
      'nav_dashboard': 'Overview',
      'nav_settings': 'Settings',
      'dashboard_title': 'Overview',
      'stat_orders': 'Orders',
      'stat_revenue': 'Revenue',
      'stat_customers': 'Customers',
      'stat_products': 'Products',
      'recent_orders': 'Recent orders',
      'view_all': 'View all',
      'status_completed': 'Completed',
      'status_processing': 'Processing',
      'status_shipping': 'Shipping',
      'status_cancelled': 'Cancelled',
    },
  };
}