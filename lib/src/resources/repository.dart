import 'dart:async';

import 'package:flutter_app/src/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider, //NewsDbProvider(),
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider, //NewsDbProvider(),
  ];

//  NewsDbProvider dbProvider = NewsDbProvider();
//  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem_(int id) async {
    // Not used
//    var item = await dbProvider.fetchItem(id);
//
//    if (item != null) {
//      return item;
//    }
//
//    item = await apiProvider.fetchItem(id);
//    dbProvider.addItem(item); // Нет необходимости дожидаться, пока зхапись будет записана в базу данный - await не используем

    ItemModel item;
    var source;

    for (source in sources) {
      ItemModel item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  Future<ItemModel> fetchItem(int id) async {
    for (Source source in sources) {
      ItemModel item = await source.fetchItem(id);
      if (item != null) {
        for (var cache in caches) {
          if (source is Cache && cache != (source as Cache)) {
            cache.addItem(item);
          }
        }
        return item;
      }
    }
    return null;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);

  Future<int> clear();
}
