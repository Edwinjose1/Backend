import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdditemScreen extends StatefulWidget {
  @override
  State<AdditemScreen> createState() => _AdditemScreenState();
}

class _AdditemScreenState extends State<AdditemScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<File> selectedImages = [];
  List<String> categories = ['Wedding', 'Birthday', 'Funeral', 'Social Events'];
  List<String> weddingSubcategories = [
    'Muslim Wedding',
    'Christian Wedding',
    'Hindu Wedding',
    'Other Wedding'
  ];
  List<String> birthdaySubcategories = [
    '1st Birthday',
    '18th Birthday',
    '30th Birthday',
    '50th Birthday',
  ];
  List<String> SocialeventsSubcategories = [
    'Community Events',
    "Sporting Events",
    "Cultural Event",
    "Group Activities"
  ];
  List<String> funeralSubcategories = [
    'Memorial Reception',
    "Memorial Service",
    "Tribute Ceremony",
    "Reflection Garden"
  ];
  List<String> subcategories = [];
  String? selectedCategory;
  String? selectedSubcategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stage'),
         backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Stage',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.green),
                        ),
                        onPressed: () async {
                          List<XFile>? files = await ImagePicker().pickMultiImage();
                          if (files != null) {
                            List<File> newImages = [];
                            for (var file in files) {
                              newImages.add(File(file.path));
                            }
                            setState(() {
                              selectedImages = newImages;
                            });
                          }
                        },
                        child: Text("Add images"),
                      ),
                      for (var image in selectedImages)
                        Image.file(
                          image,
                          width: 50.0,
                          height: 50.0,
                        ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                        selectedSubcategory = null;
                        if (selectedCategory == 'Wedding') {
                          subcategories = weddingSubcategories;
                        } else if (selectedCategory == 'Birthday') {
                          subcategories = birthdaySubcategories;
                        } else if (selectedCategory == 'Funeral') {
                          subcategories = funeralSubcategories;
                        } else if (selectedCategory == 'Social Events') {
                          subcategories = SocialeventsSubcategories;
                        } else {
                          subcategories = [];
                        }
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedSubcategory,
                    decoration: InputDecoration(
                      labelText: 'Subcategory',
                      border: OutlineInputBorder(),
                    ),
                    items: subcategories.map((String subcategory) {
                      return DropdownMenuItem<String>(
                        value: subcategory,
                        child: Text(subcategory),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSubcategory = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter available dates';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an item';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.pink),
                        ),
                        onPressed: () async {
                          if (selectedImages.length < 4) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please select at least 4 images'),
                              ),
                            );
                            return;
                          }

                          List<String> imageUrls = [];

                          for (var image in selectedImages) {
                            String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                            Reference referenceRoot = FirebaseStorage.instance.ref();
                            Reference referenceDirImages = referenceRoot.child('images');
                            Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                            try {
                              await referenceImageToUpload.putFile(image);
                              String imageUrl = await referenceImageToUpload.getDownloadURL();
                              imageUrls.add(imageUrl);
                            } catch (error) {
                              // Handle the error if necessary
                            }
                          }

                          if (_formKey.currentState!.validate()) {
                            final product = Product(
                              id: '', // Will be assigned the Firebase-generated ID
                              description: _descriptionController.text,
                              price: _priceController.text,
                              note: _noteController.text,
                              imageUrls: imageUrls,
                              category: selectedCategory!,
                              subcategory: selectedSubcategory!,
                            );
                            createUser(product);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createUser(Product product) async {
    final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
    final DocumentReference docProduct = await productsCollection.add(product.toJson());
    final String productId = docProduct.id;
    await docProduct.update({'id': productId});
  }
}

class Product {
  final String id;
  final String description;
  final String price;
  final String note;
  final List<String> imageUrls;
  final String category;
  final String subcategory;

  Product({
    required this.id,
    required this.description,
    required this.price,
    required this.note,
    required this.imageUrls,
    required this.category,
    required this.subcategory,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "price": price,
        "note": note,
        "imageUrls": imageUrls,
        "category": category,
        "subcategory": subcategory,
      };
}
