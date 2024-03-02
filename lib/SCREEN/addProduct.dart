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

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> uploadProduct({
    required String quantityCategory,
    required String productCategory,
  }) async {
    try {
      String uri = "http://18.183.210.225//cartlist_api/addproduct.php";
      var res = await http.post(Uri.parse(uri), body: {
        "productName": prName.text,
        "productBrand": prBrand.text,
        "productCategory": productCategory,
        "quantityCategory": quantityCategory,
        "productId": prId.text,
        "productRating": prRating.text,
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

  TextEditingController prName = TextEditingController();
  TextEditingController prCategory = TextEditingController();
  TextEditingController prBrand = TextEditingController();
  TextEditingController prId = TextEditingController();
  TextEditingController prRating = TextEditingController();

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
                  controller: prName,
                  decoration: InputDecoration(
                    label: const Text("product name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product Name";
                    }
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 50,
                  width: widgetSize.width,
                  child: FutureBuilder<List<String>>(
                    future: getAllCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!;
                        return DropdownButton(
                          isExpanded: true,
                          value: dropdownvalue ?? data[0],
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: data.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),

                //COUNT CATEGORY
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    focusColor: Colors.white,
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: productCountCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        productCountCategory = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: prBrand,
                  decoration: InputDecoration(
                    label: const Text("product brand"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product Brand";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: prId,
                  decoration: InputDecoration(
                    label: const Text("product id"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product ID";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: prRating,
                  decoration: InputDecoration(
                    label: const Text("product rating"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product Rating";
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
                        uploadProduct(
                            productCategory: dropdownvalue!,
                            quantityCategory: productCountCategory);
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
