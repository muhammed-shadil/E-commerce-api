import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/presentation/provider/remot_cofig_provider.dart';
import 'package:provider/provider.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';
import 'package:mechine_test_pinkolearn/presentation/provider/product_provider.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget(
      {super.key, required this.productprovider, required this.index});
  final int index;
  final ProductProvider productprovider;

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsiveness
    final size = MediaQuery.of(context).size;

    // Calculate width based on screen size
    final cardWidth = size.width * 0.45;
    final imageHeight = cardWidth * 0.8; // Adjust image height ratio

    // Fetch the product details
    final product = productprovider.products!.products[index];

    // Calculate discounted price
    final discountedPrice =
        product.price * (1 - (product.discountPercentage / 100));

    // Access RemoteConfigProvider to get the showDiscountedPrice value
    final showDiscountedPrice =
        Provider.of<RemoteConfigProvider>(context).showDiscountedPrice;

    return Container(
      width: cardWidth, // Responsive width for each card
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(
          bottom: 10), // Add margin for space between rows
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
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(product.images[0]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              product.title, // Product title
              maxLines: 2,
              style: Styles.cardtitlestyle, // Use your own style definition
            ),
          ),
          Text(
            product.description, // Product description
            style: Styles.textStyle, // Ensure text styling is consistent
            maxLines: 3,
            overflow: TextOverflow.ellipsis, // Ellipsis for overflow
          ),
          const Spacer(),
          // Price and discount section
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "\$${product.price.toStringAsFixed(2)}", // Original price
                  style: Styles.hashStyle,
                ),
                const SizedBox(width: 5), // Space between prices
                if (showDiscountedPrice) ...[
                  Text(
                    "\$${discountedPrice.toStringAsFixed(2)}", // Discounted price
                    style: Styles.middtextStyle,
                  ),
                  const SizedBox(width: 5), // Space before discount text
                  Text(
                    "${product.discountPercentage}% off", // Discount percentage
                    style: Styles.greenstyle,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
