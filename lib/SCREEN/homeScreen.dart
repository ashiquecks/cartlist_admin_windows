import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartlist Admin"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'createCategory');
              },
              title: const Text("Create Category"),
              subtitle: const Text("navigate to create category section"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'addProduct');
              },
              title: const Text("Add Products"),
              subtitle: const Text("navigate to add product section"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'sponserdSecton');
              },
              title: const Text("Sponserd Section"),
              subtitle: const Text("navigate to add Sponserd section"),
            ),
          ),
        ],
      ),
    );
  }
}
