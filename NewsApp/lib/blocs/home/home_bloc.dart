import 'package:NewsApp/data/api/api_service.dart';
import 'package:NewsApp/data/models/article_model.dart';
import 'package:NewsApp/data/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final homeRepository = Injector.appInstance.get<HomeRepository>();
  NewsListRes articleList;

  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeDataEvent) {
      try {
        yield GetHomeState(ApiStatus.LOADING);

        final NewsListRes response = await homeRepository.getPostData();

        if (response.status == 'ok') {
          articleList = response;
          yield GetHomeState(ApiStatus.SUCCESS, response: response);
        } else {
          yield GetHomeState(ApiStatus.ERROR, error: "Something went wrong!");
        }
      } catch (e) {
        yield GetHomeState(ApiStatus.ERROR, error: "Something went wrong!");
      }
    }
  }
}
