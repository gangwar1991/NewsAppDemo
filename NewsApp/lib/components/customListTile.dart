import 'package:NewsApp/data/models/article_model.dart';
import 'package:NewsApp/pages/articles_details_page.dart';
import 'package:NewsApp/pages/custom/fade_animation.dart';
import 'package:flutter/material.dart';

Widget customListTile(Articles article, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(article: article)));
    },
    child: FadeAnimation(
        0.8,
        Container(
            margin: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                  ),
                ]),
            child: Row(
              children: [
                Container(
                  height: 120.0,
                  width: 100.0,
                  //width: double.infinity,
                  decoration: BoxDecoration(
                    //let's add the height

                    image: DecorationImage(
                        image: NetworkImage(article.urlToImage),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Text(
                        article.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ))),
  );
}
