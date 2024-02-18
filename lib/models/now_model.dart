class NowModel {
  final String title, thumb, id;

  NowModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        id= json['id'].toString();
}
