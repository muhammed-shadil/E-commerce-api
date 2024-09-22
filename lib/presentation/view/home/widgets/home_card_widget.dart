import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsiveness
    final size = MediaQuery.of(context).size;

    // Calculate width based on screen size
    final cardWidth = size.width * 0.45;
    final imageHeight = cardWidth * 1.2; // Adjust image height ratio

    return Container(
      width: cardWidth, // Responsive width for each card
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10), // Add margin for space between rows
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2), // Shadows for depth effect
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Container(
            width: double.infinity,
            height: imageHeight, // Dynamic image height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://www.cnet.com/a/img/resize/b8f872ad3c40aabc68bc88ac8a79b1470ed7b9c6/hub/2024/05/07/0ceb2dd9-4fc6-417e-9042-f58b36fab653/iphone-16-rumors-00000.jpg?auto=webp&fit=crop&height=675&width=1200",
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "iPhone 9", // Product title
              style: Styles.cardtitlestyle, // Use your own style definition
            ),
          ),
          const Text(
            "An apple mobile which is nothing like apple _", // Product description
            style: Styles.textStyle, // Ensure text styling is consistent
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Ellipsis for overflow
          ),
          const Spacer(),
          // Price and discount section
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("\$549", // Original price
                  style: Styles.hashStyle),
              const SizedBox(width: 5), // Space between prices
              const Text("\$499", // Discounted price
                  style: Styles.middtextStyle),
              const SizedBox(width: 5), // Space before discount text
              Text(
                "12.5% off", // Discount percentage
                style: Styles.greenstyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
