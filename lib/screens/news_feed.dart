import 'package:flutter/material.dart';
import 'package:like_minds_news_app/components/news_card.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../services/news_data.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  var newsData;
  var prevKeyword = '';
  var searchKeyword;
  var showLoadingWidget = false;
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('News Feed'),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showLoadingWidget,
        color: Colors.black,
        dismissible: true,
        progressIndicator: RefreshProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
          backgroundColor: Colors.black,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenHeight * 0.02),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white70,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.all(screenHeight * 0.02),
                  filled: true,
                  fillColor: Colors.grey[900],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.04),
                      bottomLeft: Radius.circular(screenHeight * 0.04),
                      topRight: Radius.circular(screenHeight * 0.04),
                      bottomRight: Radius.circular(screenHeight * 0.04),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.04),
                      bottomLeft: Radius.circular(screenHeight * 0.04),
                      topRight: Radius.circular(screenHeight * 0.04),
                      bottomRight: Radius.circular(screenHeight * 0.04),
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                controller: textController,
                onSubmitted: (keyword) async {
                  if (keyword != prevKeyword) {
                    setState(() {
                      showLoadingWidget = true;
                    });
                    newsData = await NewsData(keyword: keyword).fetchNewsData();
                    setState(() {
                      showLoadingWidget = false;
                      textController.value = TextEditingValue(text: keyword);
                    });
                    prevKeyword = keyword;
                  }
                },
              ),
            ),
            (newsData == null)
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Start typing in the search box to get latest news.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: (newsData['articles']).length,
                      itemBuilder: (listViewContext, index) {
                        if (newsData != null) {
                          print(newsData['totalResults']);
                        }

                        return NewsCard(
                          title: (newsData['articles'][index]['title'] == null)
                              ? ''
                              : newsData['articles'][index]['title'],
                          author:
                              (newsData['articles'][index]['author'] == null)
                                  ? 'Unknown'
                                  : newsData['articles'][index]['author'],
                          description: (newsData['articles'][index]
                                      ['description'] ==
                                  null)
                              ? ''
                              : newsData['articles'][index]['description'],
                          imageURL: (newsData['articles'][index]
                                      ['urlToImage'] ==
                                  null)
                              ? ''
                              : newsData['articles'][index]['urlToImage'],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
