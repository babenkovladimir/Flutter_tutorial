import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/news_detail.dart';
import 'package:flutter_app/src/screens/news_list.dart';

import 'blocs/comments_provider.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final bloc = StoriesProvider.of(context);
    return CommentsProvider(
      child: StoriesProvider(
        child: new MaterialApp(
          title: 'News!',
          //home: NewsList(),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();

          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst("/", ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(itemId: itemId);
        },
      );
    }
  }
}
