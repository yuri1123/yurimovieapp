class DetailModel {
  final String title, thumb, overview, rate, id, runtime;
  final List<String> genres;

  DetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        overview = json['overview'],
        genres =
            List<String>.from(json['genres'].map((genre) => genre['name'])),
        rate = json['vote_average'].toString(),
        id = json['id'].toString(),
        runtime = json['runtime'].toString();

  DetailModel({
    this.title = '',
    this.thumb = '',
    this.overview = '',
    this.genres = const [],
    this.rate = '',
    this.id = '',
    this.runtime =''

  });

}
