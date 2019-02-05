import 'dart:convert';

import 'package:flutter_app/src/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('FetchTopIds a list of Ids', () async {
    // setup of testCase
    final sum = 1 + 3;

    // Our test
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
    expect(sum, 4);
    // expectation
  });

  test('FetchItem return a item model', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return  Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
