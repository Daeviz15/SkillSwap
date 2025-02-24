import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_swap/widgets/items.dart';

class FancyCarousel extends StatelessWidget {
  const FancyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider.builder(
      itemCount: items.length,
      itemBuilder: (context, index, realIndex) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Base image
                Image.asset(
                  cacheWidth: 642,
                  cacheHeight: 435,
                  item['image']!,
                  fit: BoxFit.cover,
                  height: 250,
                  width: screenWidth,
                ),
                // Dark overlay instead of blur
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
                // Text overlay
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    item['text']!,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 250,
        autoPlayCurve: Curves.easeInOut,
        pauseAutoPlayOnTouch: true,
        pageSnapping: true,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        viewportFraction: 0.92,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
