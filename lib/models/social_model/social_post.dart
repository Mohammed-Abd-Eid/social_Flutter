class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTame;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTame,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTame = json['dateTame'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uId": uId,
      "image": image,
      "dateTame": dateTame,
      "text": text,
      "postImage": postImage,
    };
  }
}
