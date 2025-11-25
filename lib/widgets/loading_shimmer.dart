import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCardShimmer extends StatelessWidget {
  const LoadingCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: 16),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 14,
                      width: 140,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 12,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 12,
                          width: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 12,
                          width: 60,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
