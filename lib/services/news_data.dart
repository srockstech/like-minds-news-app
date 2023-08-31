import 'networking.dart';

class NewsData {
  var _apiKey = "57d01316d3714b588ee2150f4e6fed75";
  var _keyword = "crypto";
  var _apiURL = "https://newsapi.org/v2/everything";

  NewsData({required keyword}) {
    this._keyword = keyword;
  }

  Future<dynamic> fetchNewsData() async {
    var networkHelper = NetworkHelper('$_apiURL?q=$_keyword&apiKey=$_apiKey');
    var newsData = await networkHelper.getData();
    print(newsData);
    return newsData;
  }
}
