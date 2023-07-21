import 'package:adminsideofstage/widgets/card_ontap_wiget.dart';
import 'package:flutter/material.dart';



class Stagecard extends StatelessWidget {
  final String price;
  final List<String> imageUrls;
  final int rating;
  final String category;
  final String description;
  final String subcategory;
  final String id;

  const Stagecard({
    required this.id,
    required this.price,
    required this.imageUrls,
    required this.rating,
    required this.category,
    required this.description,
    required this.subcategory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(id);
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => CardonTapScreen(
                category: category,
                description: description,
                imageUrls: imageUrls,
                price: price,
                rating: rating,
                subcategory: subcategory)),
      ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 74, 195, 124),
              ),
              width: 250,
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageUrls[0]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          height: 300,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: SizedBox(
                            width: 140,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                          subcategory,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 76, 117, 175),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Text(
                                "$rating",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Rs: ${price}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 247, 246, 246),
                        ),
                      ),
                    
                      SizedBox(width: 50),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
      
    );
  }
}
