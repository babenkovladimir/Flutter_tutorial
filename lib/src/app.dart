// Import flutter helper library
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_app/src/widgets/image_list.dart';
import 'package:http/http.dart' as http;

import 'models/image_model.dart';
//show get - in tutorial; // ЗАгрузить из пакета http только get function

// Create class that will our custom widget
//this Class must extends 'StatelessWidget' base class

// Для загрузки новой фотографии необходимо сделать отедльный метод

class App extends StatefulWidget {

  createState() {
    return AppState();
  }
}

//class AppState extends StatelessWidget{
class AppState extends State<App> {
// Must define a 'build' method returns the widgets that *this* widget will show
  int counter = 0;
  List<ImageModel> images = [];

  // Для загрузки новой фотографии необходимо сделать отедльный метод
  void fetchImage() async {
    counter++;
    var response = await http.get('https://jsonplaceholder.typicode.com/photos/'); // Этот метод возвращает future
    var imageModel = ImageModel.fromJson(json.decode(mockJson));

    // Эта команда проинформирует родительский класс о том, что были внесены изменения необходио перерисовать
    setState(() {
      images.add(imageModel);
    });

    print(response.body);
    print(counter);

    print(imageModel.title + ' ' + imageModel.id.toString() + imageModel.url);
  }

  // Life

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
//        body: Text('$counter'),
        body: ImageList(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.clear), // Добаляем child icon
            onPressed: fetchImage
//            setState(() {
//              counter += 1;
//            });
            //print('Hi there!!!');

            ),
        appBar: AppBar(
          title: Text('Lets see some images!!!'),
        ),
      ),
    );
  }
}

var mockJson =
    '{"albumId": 1, "id": 2, "title": "reprehenderit est deserunt velit ipsam", "url": "https://via.placeholder.com/600/771796", "thumbnailUrl": "https://via.placeholder.com/150/771796"}';
