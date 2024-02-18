class PopularModel {
  final String title, thumb, id;

  PopularModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        id= json['id'].toString();
}
