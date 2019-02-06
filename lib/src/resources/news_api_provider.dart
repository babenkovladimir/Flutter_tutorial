import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/item_model.dart';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = new Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json?print=pretty');
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    var url = '$_root/item/$id.json';
    final response = await client.get(url);
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
