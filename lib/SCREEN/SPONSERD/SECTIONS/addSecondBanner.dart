import 'package:cartlist_admin/MODAL/categoryModal.dart';
import 'package:cartlist_admin/PROVIDER/categoryProvider.dart';
import 'package:cartlist_admin/SERVICE/getCategoryApi.dart';
import 'package:cartlist_admin/WIDGET/alertDialogBox.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddSecondBanner extends StatefulWidget {
  const AddSecondBanner({super.key});

  @override
  State<AddSecondBanner> createState() => _AddSecondBannerState();
}

class _AddSecondBannerState extends State<AddSecondBanner> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> uploadSecondBanner() async {
    try {
      String uri = "http://18.183.210.225//cartlist_api/addsecondbanner.php";
      var res = await http.post(Uri.parse(uri), body: {
        "bannerName": bannerName.text,
        "bannerID": bannerId.text,
        "data": imageData,
        "name": imageName,
      });

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("uploaded");
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController bannerName = TextEditingController();
  TextEditingController bannerId = TextEditingController();

  File? imagePath;
  String? imageName;
  String? imageData;

  ImagePicker imagePicker = ImagePicker();

  Future<void> getImage() async {
    var getimagepath = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = File(getimagepath!.path);
      imageName = getimagepath.path.split("/").last;
      imageData = base64Encode(imagePath!.readAsBytesSync());
    });
  }

  var items = [
    'KG',
    'LITER',
    'PAK',
  ];

  // Category Response Post To Category Provider
  postCategoryResponse() async {
    var provider = Provider.of<CategoryProvider>(context, listen: false);
    var response = await Categoryservice.getCategoryResponse();

    if (response.isSuccessful!) {
      provider.setPostList(response.data!);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    postCategoryResponse();
  }

  String? dropdownvalue;

  String productCountCategory = "KG";

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                imagePath != null
                    ? Image.file(imagePath!)
                    : const Text("No Image Selected"),
                const SizedBox(height: 20),
                CircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: bannerName,
                  decoration: InputDecoration(
                    label: const Text("banner name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter banner Name";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: bannerId,
                  decoration: InputDecoration(
                    label: const Text("banner ID"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter banner ID";
                    }
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: widgetSize.width,
                  child: ElevatedButton(
                    child: const Text("SUBMIT"),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      showAlertDialogOne(context: context);
                      Future.delayed(const Duration(seconds: 3), () {
                        uploadSecondBanner();
                        showAlertDialogTwo(context: context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// http://18.183.210.225//cartlist_api/getsponserdproduct.php get all sponsor product

// http://18.183.210.225//cartlist_api/getmainbanner.php  get main banner data

// http://18.183.210.225//cartlist_api/getsecondbanner.php get second banner data