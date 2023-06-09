class CarouselModel {

  CarouselModel({required this.id, required this.image});

  final String id;
  final String image;

  CarouselModel.fromJson(Map<String, Object?> json)
      : this(id: json['title']! as String, image: json['img']! as String);

  Map<String, Object?> toJson() {
    return {
      'title': id,
      'img': image,
    };
  }
}