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

class AddMainBanner extends StatefulWidget {
  const AddMainBanner({super.key});

  @override
  State<AddMainBanner> createState() => _AddMainBannerState();
}

class _AddMainBannerState extends State<AddMainBanner> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> uploadMainBanner() async {
    try {
      String uri = "http://18.183.210.225//cartlist_api/addmainbanner.php";
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
    var getimagepath = await imagePicker.pickImage(source: ImageSource.camera);
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

  Future<List<String>> getAllCategory() async {
    var baseUrl = "http://18.183.210.225//cartlist_api/getcategorydetails.php";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element["category_name"]);
      }
      return items;
    } else {
      throw response.statusCode;
    }
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
                        uploadMainBanner();
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
