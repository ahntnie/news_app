import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'VLTT Tin Tức',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {},
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down_sharp)),
          ),
        ],
      ),
    );
  }
}
