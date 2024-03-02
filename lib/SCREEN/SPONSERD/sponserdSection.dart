import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SponserdSection extends StatefulWidget {
  const SponserdSection({super.key});

  @override
  State<SponserdSection> createState() => _SponserdSectionState();
}

class _SponserdSectionState extends State<SponserdSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'addMainBanner');
              },
              title: const Text("Create Main Banner "),
              subtitle: const Text("navigate to create Main Banner section"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'addSponsorProduct');
              },
              title: const Text("Add Sponserd Products"),
              subtitle: const Text("navigate to add Sponserd product section"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'addSecondBanner');
              },
              title: const Text("Create Scond Banner"),
              subtitle:
                  const Text("navigate to add Create Scond Banner section"),
            ),
          ),
        ],
      ),
    );
  }
}
