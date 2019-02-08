import 'dart:async';
import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // This is bad!!!!! Dont doi this!
    // temporary
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text("Top news"),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          //return Text('Still waiting for ids');
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            bloc.fetchItem(snapshot.data[index]);
//            return Text('${snapshot.data[index]}');
            return NewsListTile(itemId: snapshot.data[index],);
          },
        );
      },
    );
  }

//  Widget buildList() {
//    return ListView.builder(
//      itemCount: 1000,
//      itemBuilder: (BuildContext context, int index) {
//        return FutureBuilder(
//          future: getFuture(),
//          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//            return Container(
//              child: snapshot.hasData ? Text('Im visiba; $index') : Text('I havent fetched data yet @index'),
//              height: 80,
//            );
//          },
//        );
//      },
//    );
//  }

  getFuture() {
    // temporary test future.
    return Future.delayed(Duration(seconds: 2), () => 'Hi');
  }
}
