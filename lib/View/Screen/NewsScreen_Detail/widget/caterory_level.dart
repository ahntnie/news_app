import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryLevel extends StatefulWidget {
  const CategoryLevel({super.key});

  @override
  State<CategoryLevel> createState() => _CategoryLevelState();
}

class _CategoryLevelState extends State<CategoryLevel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {},
              child: const Text(
                "Thời sự ",
                style: TextStyle(
                    color: const Color.fromARGB(255, 250, 19, 2), fontSize: 25),
              ),
            ),
            const Text("/", style: TextStyle(fontSize: 25)),
            InkWell(
              onTap: () {},
              child: const Text(
                " Tin mới nhất",
                style: TextStyle(
                    color: Color.fromARGB(255, 207, 91, 80), fontSize: 25),
              ),
            ),
          ],
        ),
        const Row(
          children: [
            Text(
              "Thứ 6, 05/01/2024",
              style: TextStyle(fontSize: 15),
            )
          ],
        )
      ],
    );
  }
}
