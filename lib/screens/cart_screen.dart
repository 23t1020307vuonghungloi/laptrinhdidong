// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';

// Mô hình dữ liệu món hàng trong giỏ
class CartItemModel {
  final String id;
  final String name;
  final int price; // Đơn giá dạng số nguyên (VD: 250000)
  final String imageUrl;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Danh sách sản phẩm mẫu ban đầu trong giỏ hàng
  List<CartItemModel> _cartItems = [
    CartItemModel(
      id: '1',
      name: 'Điện thoại iPhone 15 Pro Max 256GB',
      price: 29990000,
      imageUrl: 'https://bizweb.dktcdn.net/thumb/1024x1024/100/459/953/products/iphone-15-pro-max-natural.jpg',
      quantity: 1,
    ),
    CartItemModel(
      id: '2',
      name: 'Tai nghe Bluetooth AirPods Pro Gen 2',
      price: 180000,
      imageUrl: 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_2_sep24_pdp_image_position_2__vn-vi.jpg',
      quantity: 2,
    ),
    CartItemModel(
      id: '3',
      name: 'Đồng hồ Apple Watch Series 9 GPS',
      price: 9890000,
      imageUrl: 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vn_apple_watch_series_9_gps_41mm_productred_aluminum_productred_sport_band_pdp_image_position-1_1.jpg',
      quantity: 1,
    ),
  ];

  // Định dạng hiển thị tiền tệ (VD: 500000 -> 500.000 đ)
  String _formatCurrency(int amount) {
    return '${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} đ';
  }

  // YÊU CẦU 4: Tính tạm tính (tổng tiền hàng)
  int get _subtotal {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // YÊU CẦU 4: Phí vận chuyển (Miễn phí từ 500.000 đ, dưới 500k là 30.000 đ)
  int get _shippingFee {
    if (_cartItems.isEmpty) return 0;
    return _subtotal >= 500000 ? 0 : 30000;
  }

  // Tổng cộng thanh toán
  int get _total => _subtotal + _shippingFee;

  // YÊU CẦU 3 & ĐẠT YÊU CẦU: Xóa sản phẩm kèm Hoàn tác (SnackBar)
  void _removeItem(int index, {bool showUndo = true}) {
    final removedItem = _cartItems[index];
    final removedIndex = index;

    setState(() {
      _cartItems.removeAt(index);
    });

    if (showUndo) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xóa "${removedItem.name}" khỏi giỏ hàng'),
          action: SnackBarAction(
            label: 'Hoàn tác',
            onPressed: () {
              setState(() {
                _cartItems.insert(removedIndex, removedItem);
              });
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // YÊU CẦU 2: Tăng / giảm số lượng, về 0 thì xóa khỏi giỏ
  void _updateQuantity(int index, int delta) {
    setState(() {
      _cartItems[index].quantity += delta;
      if (_cartItems[index].quantity <= 0) {
        _removeItem(index, showUndo: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng (${_cartItems.length})'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      // YÊU CẦU 5: Giỏ rỗng thì hiện màn hình trống
      body: _cartItems.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // YÊU CẦU 1, 2, 3: Danh sách sản phẩm dùng ListView.builder & Dismissible
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart, // Vuốt sang trái
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
                        ),
                        onDismissed: (direction) {
                          _removeItem(index, showUndo: true);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                // Ảnh nhỏ sản phẩm
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item.imageUrl,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.image, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Tên 2 dòng & Đơn giá
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        _formatCurrency(item.price),
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Bộ chọn số lượng (+ / -)
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      iconSize: 22,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => _updateQuantity(index, -1),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        '${item.quantity}',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      iconSize: 22,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => _updateQuantity(index, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // YÊU CẦU 4: Bảng tính tiền tự cập nhật
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text('Tạm tính', style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          Text(_formatCurrency(_subtotal)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Phí vận chuyển', style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          Text(
                            _shippingFee == 0 ? 'Miễn phí' : _formatCurrency(_shippingFee),
                            style: TextStyle(
                              color: _shippingFee == 0 ? Colors.green : Colors.black87,
                              fontWeight: _shippingFee == 0 ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      if (_subtotal < 500000 && _cartItems.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Mua thêm ${_formatCurrency(500000 - _subtotal)} để được Miễn phí vận chuyển',
                              style: const TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      const Divider(height: 20),
                      Row(
                        children: [
                          const Text(
                            'Tổng cộng',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            _formatCurrency(_total),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A8A),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tiến hành thanh toán!')),
                            );
                          },
                          child: const Text('Thanh toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // YÊU CẦU 5: Giao diện giỏ hàng trống khi không có sản phẩm
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 90, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Giỏ hàng của bạn đang trống',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hãy chọn thêm các sản phẩm yêu thích vào giỏ hàng nhé.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Quay lại màn hình mua sắm
              },
              child: const Text('Tiếp tục mua sắm', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}