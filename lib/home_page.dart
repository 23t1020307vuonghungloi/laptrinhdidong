import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // =====================================
      // TH 11 - ICON VÀ ICONBUTTON TRÊN APPBAR
      // =====================================

      appBar: AppBar(
        title: const Text(
          'Thực hành Widget',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          // =====================================
          // NÚT TÌM KIẾM
          // =====================================

          IconButton(
            icon: const Icon(
              Icons.search,
              size: 28,
              color: Colors.blue,
            ),
            tooltip: 'Tìm kiếm',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bạn vừa bấm Tìm kiếm'),
                ),
              );
            },
          ),

          // =====================================
          // NÚT THÔNG BÁO
          // =====================================

          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.orange,
            ),
            tooltip: 'Thông báo',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bạn vừa bấm Thông báo'),
                ),
              );
            },
          ),

          // =====================================
          // NÚT CÀI ĐẶT
          // =====================================

          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 26,
              color: Colors.grey,
            ),
            tooltip: 'Cài đặt',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bạn vừa bấm Cài đặt'),
                ),
              );
            },
          ),
        ],
      ),

      // =====================================
      // NỘI DUNG
      // =====================================

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [

              // =====================================
              // HÌNH ẢNH
              // =====================================

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),

                  child: Image.network(
                    'https://picsum.photos/400/300',

                    width: 300,
                    height: 200,

                    fit: BoxFit.cover,

                    // Hiển thị vòng xoay khi đang tải.
                    loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const SizedBox(
                        width: 300,
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },

                    // Hiển thị icon nếu ảnh lỗi.
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const SizedBox(
                        width: 300,
                        height: 200,
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 64,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =====================================
              // KHUNG THÔNG TIN SINH VIÊN
              // =====================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // =====================================
                    // TIÊU ĐỀ
                    // =====================================

                    const Center(
                      child: Text(
                        'THÔNG TIN SINH VIÊN',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // =====================================
                    // HỌ TÊN
                    // =====================================

                    const Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 24,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 12),

                        Text(
                          'Vương Hưng Lợi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // =====================================
                    // MSSV
                    // =====================================

                    const Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          size: 24,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 12),

                        Text(
                          '23T1020307',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // =====================================
                    // LỚP
                    // =====================================

                    const Row(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 24,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 12),

                        Text(
                          'Lập trình Flutter N3',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // =====================================
                    // EMAIL
                    // =====================================

                    const Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 24,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            '23T1020307@husc.edu.vn',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // =====================================
                    // MÔ TẢ
                    // =====================================

                    const Center(
                      child: Text(
                        'Sinh viên ngành Công nghệ thông tin',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}