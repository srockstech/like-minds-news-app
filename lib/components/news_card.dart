import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  final String? title;
  final String? imageURL;
  final String? description;
  final String? author;

  const NewsCard(
      {super.key,
      required this.title,
      this.imageURL,
      this.description,
      this.author});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.02),
            child: Column(
              children: [
                (widget.imageURL! != '')
                    ? Image.network(
                        widget.imageURL!,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                              height: screenHeight * 0.25,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ));
                        },
                        fit: BoxFit.fitHeight,
                        height: screenHeight * 0.25,
                      )
                    : Icon(
                        Icons.image,
                        size: screenHeight * 0.25,
                        color: Colors.grey,
                      ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  widget.title!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.022),
                ),
                SizedBox(height: screenHeight * 0.007),
                Text(
                  widget.description!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.015),
                ),
                SizedBox(height: screenHeight * 0.007),
                Text(
                  'Author: ${widget.author!}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 0,
          child: Divider(
            color: Colors.white,
            // height: ,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
