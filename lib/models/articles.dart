

class Articles {
  final String title;
  final String description;
  final String author;
  final String date;
  final String imgUrl;
  final String category;
  final String uid;

  Articles(
      {this.title,
        this.description,
        this.author,
        this.date,
        this.imgUrl,
        this.category,this.uid});

  Articles.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson['title'],
        description = parsedJson['description'],
        author = parsedJson['author name'],
        imgUrl = parsedJson['image url'],
        date = parsedJson['date'],
        category = parsedJson['category'],uid = parsedJson['user id'];
}


class FeaturedArticles {
  final String title;
  final String description;
  final String author;
  final String date;
  final String imgUrl;
  final String category;

  FeaturedArticles(
      {this.title,
        this.description,
        this.author,
        this.date,
        this.imgUrl,
        this.category});

  FeaturedArticles.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson['title'],
        description = parsedJson['description'],
        author = parsedJson['author name'],
        imgUrl = parsedJson['image url'],
        date = parsedJson['date'],
        category = parsedJson['category'];
}