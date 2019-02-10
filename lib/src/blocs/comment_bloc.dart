import 'dart:async';

import 'package:flutter_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // Streams

  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  // Sinks

  Function(int) get fetchItemWithComments => _commentFetcher.sink.add;

  // Constructor

  CommentsBloc() {
    _commentFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  // Классический пример рекурсивной загрузки
  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId)); // Повторно делаем звпрос на
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentFetcher.close();
    _commentsOutput.close();
  }
}
