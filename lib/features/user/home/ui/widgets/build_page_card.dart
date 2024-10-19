    // Function to build a page card
    import 'package:acwadcom/helpers/constants/colors.dart';
import 'package:flutter/material.dart';

Widget buildPageCard(String brand, String imagePath, String text) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0), // Adjust the padding for each card
        child: Container(
          decoration: BoxDecoration(
            color: ManagerColors.kCustomColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Image.asset(imagePath,
                  width: 100), // Replace with your image asset path
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('احصل عليه الآن'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }