import 'package:flutter/material.dart';

class MainHeadings extends StatelessWidget {
   const MainHeadings({
    super.key,required this.fontsize,required  this.color,required this.text
  });

final double fontsize;
final Color color;
final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(height: 27,width: 7,color: Colors.pink,),
          SizedBox(width: 10,),
          Text(
            text,
            style: TextStyle(fontSize: fontsize, color: color,fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
