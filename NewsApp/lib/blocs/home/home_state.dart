import 'package:NewsApp/data/api/api_service.dart';
import 'package:NewsApp/data/models/article_model.dart';

abstract class HomeState {
  HomeState([List states = const []]) : super();
}

//create initial State
class HomeInitial extends HomeState {
  HomeInitial() : super([]);
}

//create state
class GetHomeState extends HomeState {
  ApiStatus state;

  ApiStatus get apiState => state;
  NewsListRes response;
  String error;

  GetHomeState(this.state, {this.response, this.error});
}
