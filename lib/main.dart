import 'package:cartlist_admin/PROVIDER/categoryProvider.dart';
import 'package:cartlist_admin/SCREEN/SPONSERD/SECTIONS/addMainBanner.dart';
import 'package:cartlist_admin/SCREEN/SPONSERD/SECTIONS/addSecondBanner.dart';
import 'package:cartlist_admin/SCREEN/SPONSERD/SECTIONS/addSponsorProduct.dart';
import 'package:cartlist_admin/SCREEN/SPONSERD/sponserdSection.dart';
import 'package:cartlist_admin/SCREEN/addProduct.dart';
import 'package:cartlist_admin/SCREEN/createCategory.dart';
import 'package:cartlist_admin/SCREEN/homeScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => CategoryProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: 'homeScreen',
        routes: {
          'homeScreen': (context) => const HomeScreen(),
          'createCategory': (context) => const CreateCategory(),
          'addProduct': (context) => const AddProduct(),
          'sponserdSecton': (context) => const SponserdSection(),
          'addMainBanner': (context) => const AddMainBanner(),
          'addSponsorProduct': (context) => const AddSponsordProduct(),
          'addSecondBanner': (context) => const AddSecondBanner(),
        },
      ),
    );
  }
}
