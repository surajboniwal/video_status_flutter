import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RelatedVideos extends StatelessWidget {
  const RelatedVideos({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Related videos', style: GoogleFonts.montserrat(fontSize: 16)),
        Container(
          height: 150,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
