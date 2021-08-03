//Now let's create the article details page
import 'package:NewsApp/data/models/article_model.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final Articles article;
  final int index;

  ArticlePage({this.article, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: TabBarView(children: [
        // This CustomScrollView display the Home tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar(article.title),

            // Anther sliver widget: SliverList
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: mainContent(),
                ),
              ]),
            ),
          ],
        ),

        // This shows the Settings tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar(article.title),

            // Show other sliver stuff
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: mainContent(),
                ),
              ]),
            ),
          ],
        )
      ]),
    ));
  }

  Widget mainContent() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.0,
          ),
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              article.source.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  SliverAppBar showSliverAppBar(String screenTitle) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Image.network(
            article.urlToImage,
            fit: BoxFit.cover,
          )),
      title: Text(screenTitle),
      bottom: TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        tabs: [
          Tab(
            text: 'Entertainment',
          ),
          Tab(
            text: 'Popular',
          )
        ],
      ),
    );
  }
}
