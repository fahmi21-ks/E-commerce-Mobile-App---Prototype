import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart_page.dart';
import 'product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAFA5A1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Search and Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'what are you looking for',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartPage()),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Promo on Going
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Promo on Going',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  _buildTimerBox('2'),
                  _buildTimerBox('4'),
                  const Text(' : '),
                  _buildTimerBox('5'),
                  _buildTimerBox('9'),
                  const Text(' : '),
                  _buildTimerBox('5'),
                  _buildTimerBox('9'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Vertical List of Banners
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildPromoCard(
                    title: 'Discount up to',
                    highlight: '25%',
                    subtitle: 'discount for all hoodies',
                    date: '25- 29 June 2025',
                    imageUrl: 'assets/images/one.jpg',
                  ),
                  const SizedBox(height: 20),
                  _buildPromoCard(
                    title: 'Your vibe',
                    highlight: "isn't rented-\nit's custom",
                    subtitle: '',
                    date: '',
                    imageUrl: 'assets/images/two.jpg',
                    isTextOnly: true,
                  ),
                  const SizedBox(height: 20),
                  _buildPromoCard(
                    title: 'Imagine a hoodie',
                    highlight: 'so heavy it holds\nits structure even\nafter 12 hours on\nthe concrete',
                    subtitle: '',
                    date: '',
                    imageUrl: 'assets/images/three.jpg',
                    isTextOnly: true,
                    smallText: true,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Bar (Home Indicator)
      bottomNavigationBar: Container(
        height: 30,
        alignment: Alignment.center,
        color: Colors.white,
        child: Container(
          width: 100,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerBox(String digit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        digit,
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPromoCard({
    required String title,
    required String highlight,
    required String subtitle,
    required String date,
    required String imageUrl,
    bool isTextOnly = false,
    bool smallText = false,
  }) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isTextOnly) ...[
              Text(
                title,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
              ),
              Text(
                highlight,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              ),
            ] else ...[
               Text(
                highlight,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: smallText ? 14 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (date.isNotEmpty)
                  Text(
                    date,
                    style: GoogleFonts.poppins(color: Colors.white70, fontSize: 10),
                  )
                else
                  const SizedBox(),
                GestureDetector(
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD4C69D), Color(0xFF5D5135)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'shop now',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
