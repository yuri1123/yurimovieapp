class CommingModel {
  final String title, thumb, id;

  CommingModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        id= json['id'].toString();
}
