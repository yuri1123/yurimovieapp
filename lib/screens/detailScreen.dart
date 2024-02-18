import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yurimovieapp/models/detail_model.dart';
import 'package:yurimovieapp/services/apiService.dart';

class DetailScreen extends StatefulWidget {
  final String movieId;

  DetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailModel _detailModel;

  @override
  void initState() {
    super.initState();
    _detailModel = DetailModel(); // 기본값으로 초기화
    _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    try {
      DetailModel detailModel = await ApiService.getMovieById(widget.movieId);
      setState(() {
        _detailModel = detailModel;
      });
    } catch (e) {
      print('Error fetching movie details: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    int minutes =
        _detailModel.runtime != null ? int.parse(_detailModel.runtime) : 0;

    int hours = minutes ~/ 60; // 분을 시간으로 나눈 몫
    int remainingMinutes = minutes % 60; // 분을 시간으로 나눈 나머지

    String timeString = '$hours시간 $remainingMinutes분';

    // 평점을 10점 만점에서 5점 만점으로 변환
    double rating =
        _detailModel.rate != null ? double.parse(_detailModel.rate) / 2.0 : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: _detailModel != null
          ? Stack(
              children: [
                // 배경 이미지
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/' + _detailModel.thumb,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 나머지 내용
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 300), // 배경 이미지와 겹치지 않도록 높이만큼 여백 추가
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _detailModel.title,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                        // 별점 표시 위젯
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBar.builder(
                            initialRating: rating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            // 절반 별평도 허용
                            itemCount: 5,
                            itemSize: 24,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              // 사용자가 별점을 업데이트할 때의 작업을 수행합니다.
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '$timeString | ${_detailModel.genres.join(', ')}',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Storyline',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Overview: ${_detailModel.overview}',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      // 버튼이 눌린 상태일 때 노란색으로 변경합니다.
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.yellow;
                                      }
                                      // 버튼의 일반적인 상태일 때는 노란색으로 설정합니다.
                                      return Colors.yellow;
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          18.0), // 원하는 수치로 조정하세요
                                      // 다른 속성들도 필요에 따라 추가하세요
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 60),
                                  child: Text(
                                    'BUY TICKET',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(), // 데이터 로딩 중에 보여줄 위젯
            ),
    );
  }
}
