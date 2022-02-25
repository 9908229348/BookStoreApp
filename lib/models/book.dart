class Book {
  String? id;
  String? image;
  String? title;
  String? author;
  String? price;

  Book({this.id, this.image, this.title, this.author, this.price});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    author = json['author'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "title": title,
      "author": author,
      "price": price
    };
  }
}
