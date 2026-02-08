import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample data
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Hoodie',
      'price': 39000,
      'quantity': 1,
      'image': 'assets/images/hoodie.webp',
      'checked': true,
    },
    {
      'name': 'Veste Motif Homme',
      'price': 199000,
      'quantity': 1,
      'image': 'assets/images/veste.jpg',
      'checked': true,
    },
  ];

  bool _selectAll = true;

  @override
  Widget build(BuildContext context) {
    int totalItems = 0;
    int totalPrice = 0;
    for (var item in _cartItems) {
      if (item['checked']) {
        totalItems += (item['quantity'] as int);
        totalPrice += (item['price'] as int) * (item['quantity'] as int);
      }
    }
    int shippingFee = 8000;
    int totalPayment = totalPrice + shippingFee;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Cart',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF0F0F0)),
              child: const Icon(Icons.edit_outlined, color: Colors.black, size: 20),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: item['checked'],
                        activeColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) {
                          setState(() {
                            item['checked'] = val;
                            _updateSelectAll();
                          });
                        },
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(item['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item['price']} dt',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Quantity',
                              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildQtyBtn(Icons.remove, () {
                                  if (item['quantity'] > 1) {
                                    setState(() {
                                      item['quantity']--;
                                    });
                                  }
                                }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    '${item['quantity']}',
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _buildQtyBtn(Icons.add, () {
                                  setState(() {
                                    item['quantity']++;
                                  });
                                }, isAdd: true),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSummaryRow('Shipping Option', 'First Delivery >'),
                const SizedBox(height: 12),
                _buildSummaryRow('Address', 'Cité El Omrane\nMonastir', isAddress: true),
                const SizedBox(height: 12),
                _buildSummaryRow('Total Items ($totalItems)', '$totalPrice dt'),
                const SizedBox(height: 8),
                _buildSummaryRow('Shipping Fee', '$shippingFee dt'),
                const Divider(height: 24),
                _buildSummaryRow('Total Payment', '$totalPayment dt', isTotal: true),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _selectAll,
                          activeColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) {
                            setState(() {
                              _selectAll = val ?? false;
                              for (var item in _cartItems) {
                                item['checked'] = _selectAll;
                              }
                            });
                          },
                        ),
                        Text('Select All', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Pay Now',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateSelectAll() {
    bool all = true;
    for (var item in _cartItems) {
      if (!item['checked']) {
        all = false;
        break;
      }
    }
    _selectAll = all;
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap, {bool isAdd = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isAdd ? Colors.blue : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: isAdd ? Colors.white : Colors.black54),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isAddress = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isAddress ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 18 : 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
