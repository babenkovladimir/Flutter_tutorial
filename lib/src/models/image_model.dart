class ImageModel {
  int id;
  String url;
  String title;

  ImageModel(this.id, this.title, this.url);

//  ImageModel.fromJson(parcedJson) {
  ImageModel.fromJson(Map<String, dynamic> parcedJson) {
    id = parcedJson['id'];
    url = parcedJson['url'];
    title = parcedJson["title"];
  }

  ImageModel.fromJson1(Map<String, dynamic> parcedJson)
      : id = parcedJson['id'],
        url = parcedJson['url'],
        title = parcedJson["title"];
}
