// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../app_settings.dart';
import 'product_list_screen.dart';
import 'settings_screen.dart';

class _StatItem {
  final String titleKey;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.titleKey,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class _OrderItem {
  final String id;
  final String customer;
  final String date;
  final String statusKey;
  final Color statusColor;
  final String total;

  const _OrderItem({
    required this.id,
    required this.customer,
    required this.date,
    required this.statusKey,
    required this.statusColor,
    required this.total,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavIndex = 1;

  static const _stats = [
    _StatItem(
      titleKey: 'stat_orders',
      value: '1,284',
      icon: Icons.shopping_bag_outlined,
      color: Colors.blue,
    ),
    _StatItem(
      titleKey: 'stat_revenue',
      value: '128.5M',
      icon: Icons.attach_money,
      color: Colors.green,
    ),
    _StatItem(
      titleKey: 'stat_customers',
      value: '852',
      icon: Icons.people_outline,
      color: Colors.orange,
    ),
    _StatItem(
      titleKey: 'stat_products',
      value: '340',
      icon: Icons.inventory_2_outlined,
      color: Colors.purple,
    ),
  ];

  static const _recentOrders = [
    _OrderItem(
      id: '#ORD-9582',
      customer: 'Nguyễn Văn A',
      date: '02/11/2026',
      statusKey: 'status_completed',
      statusColor: Colors.green,
      total: '1.250.000 đ',
    ),
    _OrderItem(
      id: '#ORD-9581',
      customer: 'Trần Thị B',
      date: '02/11/2026',
      statusKey: 'status_processing',
      statusColor: Colors.orange,
      total: '450.000 đ',
    ),
    _OrderItem(
      id: '#ORD-9580',
      customer: 'Lê Hoàng C',
      date: '01/11/2026',
      statusKey: 'status_shipping',
      statusColor: Colors.blue,
      total: '2.890.000 đ',
    ),
    _OrderItem(
      id: '#ORD-9579',
      customer: 'Phạm Minh D',
      date: '01/11/2026',
      statusKey: 'status_cancelled',
      statusColor: Colors.red,
      total: '780.000 đ',
    ),
    _OrderItem(
      id: '#ORD-9578',
      customer: 'Đỗ Quý E',
      date: '31/10/2026',
      statusKey: 'status_completed',
      statusColor: Colors.green,
      total: '3.400.000 đ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final theme = Theme.of(context);
        final subTextColor = theme.colorScheme.onSurfaceVariant;
        const brandBlue = Color(0xFF1E3A8A);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              settings.t('dashboard_title'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: brandBlue,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. LƯỚI 4 THẺ THỐNG KÊ TỔNG QUÁT
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 700 ? 4 : 2;
                    final cardHeight =
                        settings.textScaleFactor > 1.0 ? 170.0 : 145.0;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisExtent: cardHeight,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: _stats.length,
                      itemBuilder: (context, index) {
                        final item = _stats[index];
                        return Card(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor:
                                      item.color.withOpacity(0.15),
                                  child: Icon(
                                    item.icon,
                                    color: item.color,
                                    size: 20,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.value,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      settings.t(item.titleKey),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: subTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 24),

                // 2. TIÊU ĐỀ ĐƠN HÀNG GẦN ĐÂY
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      settings.t('recent_orders'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(settings.t('view_all')),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // 3. DANH SÁCH ĐƠN HÀNG GẦN ĐÂY
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _recentOrders.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final order = _recentOrders[index];
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.id,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${order.customer} • ${order.date}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: subTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        order.statusColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    settings.t(order.statusKey),
                                    style: TextStyle(
                                      color: order.statusColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  order.total,
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 4. THANH 3 NÚT DƯỚI ĐỒNG BỘ NGÔN NGỮ
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentNavIndex,
            indicatorColor: brandBlue.withOpacity(0.15),
            onDestinationSelected: (int index) async {
              if (index == 1) {
                setState(() => _currentNavIndex = 1);
                return;
              }

              if (index == 0) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductListScreen(),
                    ),
                  );
                }
                return;
              }

              if (index == 2) {
                setState(() => _currentNavIndex = 2);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
                if (mounted) {
                  setState(() => _currentNavIndex = 1);
                }
              }
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.grid_view_outlined),
                selectedIcon: const Icon(Icons.grid_view, color: brandBlue),
                label: settings.t('nav_products'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.dashboard_outlined),
                selectedIcon: const Icon(Icons.dashboard, color: brandBlue),
                label: settings.t('nav_dashboard'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings, color: brandBlue),
                label: settings.t('nav_settings'),
              ),
            ],
          ),
        );
      },
    );
  }
}