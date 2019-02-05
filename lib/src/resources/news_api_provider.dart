import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = new Client();

  fetchTopIds() async {
    final response = await client.get('$_root/topstories.json?print=pretty');
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    var url = '$_root/item/$id.json';
    final response = await client.get(url);
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
