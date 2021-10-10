class Show {
  String title;
  String publisher;
  String image;
  String description;
  String link;
  bool following;

  Show({
    required this.title,
    required this.publisher,
    required this.image,
    required this.description,
    required this.link,
    required this.following,
  });

  Show.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        publisher = json['publisher'],
        image = json['image'],
        description = json['description'],
        link = json['link'],
        following = json['following'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['publisher'] = this.publisher;
    data['image'] = this.image;
    data['description'] = this.description;
    data['link'] = this.link;
    data['following'] = this.following;
    return data;
  }
}
