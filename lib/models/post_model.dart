class PostModel {
  String? name;
  String? text;
  String? dateTime;
  String? uId;
  String? image;
  String? imagePost;

  PostModel({
    required this.name,
    required this.text,
    required this.dateTime,
    required this.uId,
    required this.image,
    required this.imagePost,
  });

  PostModel.fromJson(
    Map<String?, dynamic> json,
  ) {
    name = json['name'];
    text = json['text'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    image = json['image'];
    imagePost = json['imagePost'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'dateTime': dateTime,
      'uId': uId,
      'image': image,
      'imagePost': imagePost,
    };
  }
}
