import 'package:adminsideofstage/widgets/stage_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = []; // Initialize as an empty list
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void fetchProducts() async {
    List<Product> products = await getAllProducts();
    setState(() {
      _allProducts = products;
      _filteredProducts = products;
    });
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(_allProducts); // Assign a copy of all products
      } else {
        _filteredProducts = _allProducts
            .where((product) =>
                product.subcategory.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.redAccent,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color.fromARGB(119, 40, 15, 37),
            ),
            height: 55,
            width: 55,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _searchController,
                onChanged: _filterProducts,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(119, 40, 15, 37),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75, // Adjust as needed
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  Product product = _filteredProducts[index];
                  return buildProduct(product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProduct(Product product) => InkWell(
        onTap: () {
          
        },
        child: Stagecard(
          id: product.id,
          subcategory:product.subcategory,
          rating: 4,
          price: product.price,
    
          imageUrls: product.imageUrls,
          category: product.category,
          description: product.description,
        ),
      );

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      snapshot. docs.forEach((DocumentSnapshot doc) {
        Product product = Product.fromJson(doc.data() as Map<String, dynamic>);
        products.add(product);
      });
    } catch (error) {
      print('Error getting products: $error');
    }

    return products;
  }
}

class Product {
  final String subcategory;
  final String category;
  final String description;
  final String price;
  final String note;
  final String id;
  final List<String> imageUrls;

  Product({
    required this.subcategory,
required this.id,
    required this.category,
    required this.description,
    required this.price,
    required this.note,
    required this.imageUrls,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: json['category'],
        subcategory: json['subcategory'],
        description: json['description'],
        price: json['price'],
        id: json['id'],
        
        note: json['note'],
        imageUrls: (json['imageUrls'] as List<dynamic>?)
                ?.map((imageUrl) => imageUrl as String)
                .toList() ??
            [],
      );
}
