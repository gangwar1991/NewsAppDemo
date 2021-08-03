import 'package:NewsApp/data/models/article_model.dart';
import 'package:NewsApp/data/models/tesla_news_res.dart';
import 'package:NewsApp/data/providers/home_provider.dart';

class HomeRepository {
  final HomeProvider homeProvider;
  HomeRepository({this.homeProvider});

  Future<NewsListRes> getPostData() async {
    final response = await homeProvider.getNewsList();
    if (response.success) {
      NewsListRes _response = NewsListRes.fromJson(response.body);
      return _response;
    } else {
      return NewsListRes();
    }
  }

  Future<TeslaNewsRes> getTeslaNews() async {
    final response = await homeProvider.getTeslaList();
    if (response.success) {
      TeslaNewsRes _response = TeslaNewsRes.fromJson(response.body);
      return _response;
    } else {
      return TeslaNewsRes();
    }
  }
}
