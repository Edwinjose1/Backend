import 'package:adminsideofstage/widgets/heading.dart';
import 'package:adminsideofstage/widgets/paragraph_text.dart';
import 'package:flutter/material.dart';

import 'main_headingds.dart';



class CardonTapScreen extends StatefulWidget {
  const CardonTapScreen({
    Key? key,
    required this.price,

    required this.imageUrls,
    required this.rating,
    required this.category,
    required this.description,
    required this.subcategory,
  }) : super(key: key);

  final String price;
  final List<String> imageUrls;
  final int rating;
  final String category;
  final String description;
  final String? subcategory;

  @override
  State<CardonTapScreen> createState() => _CardonTapScreenState();
}

class _CardonTapScreenState extends State<CardonTapScreen> {
  int currentIndex = 0;
  late PageController controller;
  late List<String> images;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    images = widget.imageUrls;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              SizedBox(
                height: 400,
                width: double.infinity,
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index % images.length;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Image.network(
                          images[index % images.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Headings(fontsize: 20, color: Colors.black, text: widget.price),
              SizedBox(width: 120),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < images.length; i++)
                buildIndicator(currentIndex == i)
            ],
          ),
          MainHeadings(
            fontsize: 25,
            color: Colors.black,
            text: 'More details',
          ),
          Headings(
            fontsize: 20,
            color: Colors.black,
            text: widget.category,
          ),
          ParagraphText(
            fontsize: 15,
            color: Colors.black,
            text: widget.description,
          ),
        ],
      ),
     
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}

