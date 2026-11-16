// lib/screens/product_list_screen.dart
import 'package:flutter/material.dart';
import '../app_settings.dart';
import 'product_card.dart';
import 'cart_screen.dart';
import 'dashboard_screen.dart';
import 'settings_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _searchQuery = '';
  String _selectedCategoryKey = 'cat_all';
  int _currentNavIndex = 0;
  final int _cartCount = 3;

  final List<String> _categoryKeys = const [
    'cat_all',
    'cat_phone',
    'cat_laptop',
    'cat_watch',
    'cat_accessory',
  ];

  final List<Product> _allProducts = const [
    Product(
      id: '1',
      name: 'Điện thoại iPhone 15 Pro Max 256GB',
      nameEn: 'iPhone 15 Pro Max 256GB Smartphone',
      category: 'cat_phone',
      price: '29.990.000 đ',
      originalPrice: '34.990.000 đ',
      discount: '-14%',
      rating: 4.9,
      reviewCount: 210,
      imageUrl:
          'https://bizweb.dktcdn.net/thumb/1024x1024/100/459/953/products/iphone-15-pro-max-natural.jpg',
      images: [
        'https://bizweb.dktcdn.net/thumb/1024x1024/100/459/953/products/iphone-15-pro-max-natural.jpg',
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/iphone15-pro-max-titan-den.jpg',
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/iphone15-pro-max-titan-trang.jpg',
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/iphone15-pro-max-titan-xanh.jpg',
      ],
    ),
    Product(
      id: '2',
      name: 'Laptop MacBook Air M2 13.6 inch',
      nameEn: 'MacBook Air M2 13.6-inch Laptop',
      category: 'cat_laptop',
      price: '24.500.000 đ',
      originalPrice: '27.990.000 đ',
      discount: '-12%',
      rating: 4.8,
      reviewCount: 85,
      imageUrl:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/macbook_air_m2_1_2.jpg',
      images: [
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/macbook_air_m2_1_2.jpg',
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/macbook_air_m2_4_2.jpg',
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/macbook_air_m2_3_2.jpg',
      ],
    ),
    Product(
      id: '3',
      name: 'Đồng hồ Apple Watch Series 9 GPS',
      nameEn: 'Apple Watch Series 9 GPS Smartwatch',
      category: 'cat_watch',
      price: '9.890.000 đ',
      originalPrice: '11.490.000 đ',
      discount: '-13%',
      rating: 4.7,
      reviewCount: 45,
      imageUrl:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vn_apple_watch_series_9_gps_41mm_productred_aluminum_productred_sport_band_pdp_image_position-1_1.jpg',
      images: [
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vn_apple_watch_series_9_gps_41mm_productred_aluminum_productred_sport_band_pdp_image_position-1_1.jpg',
        'https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vn_apple_watch_series_9_gps_41mm_silver_aluminum_storm_blue_sport_band_pdp_image_position-1_1_1.jpg',
      ],
    ),
    Product(
      id: '4',
      name: 'Tai nghe Bluetooth AirPods Pro Gen 2',
      nameEn: 'AirPods Pro Gen 2 Bluetooth Earbuds',
      category: 'cat_accessory',
      price: '5.690.000 đ',
      originalPrice: '6.790.000 đ',
      discount: '-16%',
      rating: 4.9,
      reviewCount: 310,
      imageUrl:
          'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_2_sep24_pdp_image_position_2__vn-vi.jpg',
      images: [
        'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_2_sep24_pdp_image_position_2__vn-vi.jpg',
        'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_2_sep24_pdp_image_position_1__vn-vi.jpg',
      ],
    ),
  ];

  List<Product> get _filteredProducts {
    return _allProducts.where((product) {
      final matchesCategory = _selectedCategoryKey == 'cat_all' ||
          product.category == _selectedCategoryKey;
      final query = _searchQuery.toLowerCase();
      final matchesSearch = product.name.toLowerCase().contains(query) ||
          (product.nameEn?.toLowerCase().contains(query) ?? false);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        const brandBlue = Color(0xFF1E3A8A);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'ShopEasy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: brandBlue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: settings.t('search_tooltip'),
                onPressed: () => _searchFocusNode.requestFocus(),
              ),
              IconButton(
                icon: Badge(
                  label: Text('$_cartCount'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                tooltip: settings.t('cart_tooltip'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: settings.t('search_hint'),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                        ),
                        filled: true,
                        fillColor: isDark
                            ? theme.colorScheme.surfaceContainerHighest
                            : Colors.grey.shade100,
                      ),
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: _categoryKeys.map((catKey) {
                        final isSelected = _selectedCategoryKey == catKey;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(settings.t(catKey)),
                            selected: isSelected,
                            showCheckmark: false,
                            selectedColor: brandBlue,
                            backgroundColor: isDark
                                ? theme.colorScheme.surfaceContainerHigh
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            onSelected: (_) {
                              setState(() => _selectedCategoryKey = catKey);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Expanded(
                    child: _filteredProducts.isEmpty
                        ? Center(child: Text(settings.t('no_products')))
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final baseHeight =
                                  constraints.maxWidth > 550 ? 345.0 : 305.0;
                              final extraHeight = settings.textScaleFactor > 1.0
                                  ? (settings.textScaleFactor - 1.0) * 140
                                  : 0.0;

                              return GridView.builder(
                                padding: const EdgeInsets.all(12),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: baseHeight + extraHeight,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: _filteredProducts.length,
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    product: _filteredProducts[index],
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentNavIndex,
            indicatorColor: brandBlue.withOpacity(0.15),
            onDestinationSelected: (int index) async {
              if (index == 0) {
                setState(() => _currentNavIndex = 0);
                return;
              }

              setState(() => _currentNavIndex = index);

              if (index == 1) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              } else if (index == 2) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              }

              if (mounted) {
                setState(() => _currentNavIndex = 0);
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