import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphText extends StatelessWidget {
   const ParagraphText({
    super.key,required this.fontsize,required  this.color,required this.text
  });

final double fontsize;
final Color color;
final String text;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              
              SizedBox(width: 10),
              Expanded( // Wrap the Text widget with Expanded
                child: Text(
                  text,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.lora(
                    fontSize: fontsize,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );


  
  }
}
