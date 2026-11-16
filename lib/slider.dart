import 'dart:ui';
import 'package:flutter/material.dart';

// Đăng ký hành vi cuộn cho phép kéo bằng Chuột và Trackpad trên Web/Desktop
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  // viewportFraction = 0.85 để giữ khoảng cách hiển thị 2 ảnh hai bên hợp lý
  final PageController _controller = PageController(viewportFraction: 0.85);

  // Danh sách link ảnh Unsplash ổn định, hỗ trợ CORS trên Flutter Web
  final List<String> images = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
    'https://images.unsplash.com/photo-1511884642898-4c92249e20b6?w=800',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800',
    'https://images.unsplash.com/photo-1426604966848-d7adac402bff?w=800',
    'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=800',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              images[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Không tải được ảnh'),
                  ],
                ),
              ),
            ),
            // Gradient đổ bóng và tiêu đề "No. x image"
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 20.0,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  'No. $index image',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Complicated image slider demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          // Giới hạn chiều rộng tối đa 800px để giao diện không bị giãn quá đà trên Web Desktop
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            // Giữ tỷ lệ khung hình chuẩn 16:9
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ScrollConfiguration(
                behavior: AppScrollBehavior(),
                child: PageView.builder(
                  controller: _controller,
                  itemCount: images.length,
                  itemBuilder: (context, index) => buildItem(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}