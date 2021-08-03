import 'dart:async';

import 'package:NewsApp/blocs/home/home_event.dart';
import 'package:NewsApp/data/models/article_model.dart';
import 'package:NewsApp/utils/Log.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

import 'blocs/bloc_manager.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/home/home_state.dart';
import 'components/customListTile.dart';
import 'data/api/api_service.dart';
import 'dependency_injections.dart';

void main() {
  runZonedGuarded(() {
    setupDependencyInjections();
    runApp(MyApp());
  }, (error, stackTrace) {});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(
                    HomeInitial(),
                  )),
        ],
        child: MaterialApp(
          home: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> updatedNewsList = [];

  List<Widget> _children;
  int _articleIndex = 0;
  HomeBloc get homeBloc => BlocProvider.of<HomeBloc>(context);
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeBloc>(context).add(
      HomeDataEvent(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News App", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),

        //Now let's call the APi services with futurebuilder wiget
        body: BlocManager(
            initState: (context) {},
            child: BlocListener<HomeBloc, HomeState>(
                bloc: homeBloc,
                listener: (context, state) {
                  if (state is GetHomeState) _handleNewsResponse(state);
                },
                child: homeBloc.articleList == null
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Popular News',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              child: CarouselSlider(
                                items: homeBloc.articleList.articles
                                    .map<Widget>((item) => Container(
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.yellow, width: 2),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                item.urlToImage,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  left: 0,
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(.7),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                          item.title,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )))
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    enableInfiniteScroll: false,
                                    aspectRatio: 16 / 9,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _articleIndex = index;
                                      });
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Container(
                                child: ReorderableColumn(
                              draggingWidgetOpacity: .4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              needsLongPressDraggable: true,
                              children: _children,
                              onReorder: _onReorder,
                            ))
                          ],
                        ),
                      ))));
  }

  Widget _draggableCard({Articles article}) {
    return customListTile(article, context);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _children.removeAt(oldIndex);
      _children.insert(newIndex, row);
      Articles oldItem = homeBloc.articleList.articles.elementAt(oldIndex);
      Articles newItem = homeBloc.articleList.articles.elementAt(newIndex);
      homeBloc.articleList.articles[oldIndex] = newItem;
      homeBloc.articleList.articles[newIndex] = oldItem;
      updatedNewsList = [];
      for (Articles article in homeBloc.articleList.articles) {
        updatedNewsList.add(article);
      }
    });
  }

  void _handleNewsResponse(state) {
    try {
      var homeState = state as GetHomeState;

      setState(() {
        switch (homeState.apiState) {
          case ApiStatus.LOADING:
            Log.v("Loading....................");
            // _isLoading = true;
            break;
          case ApiStatus.SUCCESS:
            Log.v(
                "_handlePostFeedResponse Success....................${homeState.response.status}");
            _children = List<Widget>.generate(
              homeBloc.articleList.articles.length,
              (int index) => Container(
                key: ValueKey(index),
                child: _draggableCard(
                    article: homeBloc.articleList.articles[index]),
              ),
            );
            // _isLoading = false;
            break;

          case ApiStatus.ERROR:
            //_isLoading = false;
            Log.v(
                "Error.......................... ${homeState.response.status}");

            break;
          case ApiStatus.INITIAL:
            // TODO: Handle this case.
            break;
        }
      });
    } catch (e) {}
  }
}
