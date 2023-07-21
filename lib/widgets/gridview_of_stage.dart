import 'dart:developer';

import 'package:adminsideofstage/widgets/stage_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StageGridview extends StatelessWidget {
  int rating = 10;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: readProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong: ${snapshot.error}");
        } else if (snapshot.hasData) {
          print('.....................entres');
           print(snapshot.data!.docs.length);

          final products = snapshot.data!.docs
              .map((doc) => Product.fromJson(doc.data()))
              .toList();
              log(products.toString());
             
          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: products.map(buildProduct).toList(),
          );
        } else {
          return Center(
            
            child: CircularProgressIndicator(),
          
          );
        }
      },
    );
  }

  Widget buildProduct(Product product) => InkWell(
        onTap: () {
          
        },
        child: Stagecard(
          subcategory: product.subcategory,
          rating: rating,
          price: product.price,
          id: product.id,
          imageUrls: product.imageUrls,
          category: product.category,
          description: product.description,
        ),
      );

  Stream<QuerySnapshot<Map<String, dynamic>>> readProduct() =>
      FirebaseFirestore.instance.collection('products').snapshots();
}

class Product {
  final String category;
  final String description;
  final String price;
  final String id;
  final String note;
  final List<String> imageUrls;
  final String subcategory;

  Product({
    required this.id,
    required this.category,
    required this.description,
    required this.price,
    required this.note,
    required this.subcategory,
    required this.imageUrls,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        category: json['category'],
        description: json['description'],
        subcategory: json['subcategory'],
        price: json['price'],
        note: json['note'],
        imageUrls: (json['imageUrls'] as List<dynamic>?)
                ?.map((imageUrl) => imageUrl as String)
                .toList() ??
            [],
      );
}
