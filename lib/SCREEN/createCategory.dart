import 'dart:convert';
import 'dart:io';
import 'package:cartlist_admin/WIDGET/alertDialogBox.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> uploadimage() async {
    try {
      String uri = "http://18.183.210.225//cartlist_api/createcategory.php";
      var res = await http.post(Uri.parse(uri), body: {
        "categoryName": ctName.text,
        "categoryId": ctId.text,
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

  TextEditingController ctName = TextEditingController();
  TextEditingController ctId = TextEditingController();

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

    print("(((((((((((((((((((((((())))))))))))))))))))))))");

    print(imagePath);
    print(imageName);
    print(imageData);
  }

  @override
  Widget build(BuildContext context) {
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
                ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: const Text("Pick Image"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ctName,
                  decoration: InputDecoration(
                    label: const Text("category name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Category Name";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ctId,
                  decoration: InputDecoration(
                    label: const Text("category id"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Category ID";
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
                          uploadimage();
                          showAlertDialogTwo(context: context);
                        });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
