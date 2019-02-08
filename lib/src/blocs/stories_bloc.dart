import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Observable<Map<int, Future<ItemModel>>> items; // Обсёрвабле мапа. И все буду обращаться только к ней!!!

  // Getters to get stream inside application

  // Getter to stream
  Observable<List<int>> get topIds => _topIds.stream;
  // Don't do it this wil be removed
  // Это плохо, потому что при каждом обращении мы будем обращаться к методу itemsTransformer и Создавать новую Map
  //get items => _items.stream.transform(_itemsTransformer()); - Это был пример, который нельзя использовать;


  // Getter for Sinks
  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc(){
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        print('this is index $index');
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{}, // Initial value empty map
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}

/*
* Каждый раз, когда мы создаём новый StoriesBloc, мы будем создавать мы будем описывать-создавать инстансь items, котрая
* будет непосредственно мапой. Создавая контроллер для мы применяем для него трансформация только один раз и привязываем его к
*
* */
