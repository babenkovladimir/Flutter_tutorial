import 'package:flutter/material.dart';

import 'blocs/stories_provider.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final bloc = StoriesProvider.of(context);

    return StoriesProvider(
      child: new MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}
