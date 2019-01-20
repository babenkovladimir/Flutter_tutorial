import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/image_model.dart';

// This is parent element. Он не будет самостоятеотно менять совё состояние
class ImageList extends StatelessWidget {
  // Поскольку мы экстендимя от StatelessWidget, то переменная должна быть final
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
//        return Text(images[index].url);
        return buildImage(images[index]);
      },
    );
  }

  Widget buildImage(ImageModel image) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(
              child: Image.network(image.url),
              padding: EdgeInsets.only(bottom: 8.0),
            ),
            Text(image.title)
          ],
        ));
  }
}

// Чтобы сделать Border - у конструктора Container нету. Необходимо использовать Decoration
// Index - индекс елемента, который собирается быть отрендереным
