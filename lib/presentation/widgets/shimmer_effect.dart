import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading:
                  const CircleAvatar(backgroundColor: Colors.white, radius: 25),
              title: Container(height: 10, width: 100, color: Colors.white),
              subtitle: Container(height: 10, width: 150, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
