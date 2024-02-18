import 'package:flutter/material.dart';
import 'package:yurimovieapp/screens/detailScreen.dart';

class PopularMovie extends StatelessWidget {
  final String title, thumb, id;

  PopularMovie(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // fullscreenDialog: true,
            builder: (context) => DetailScreen(movieId: id),
          ),
        );
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Hero(
          tag: id,
          child: Container(
            width: 250,
            height: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network('https://image.tmdb.org/t/p/w500/$thumb',
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return Text('이미지를 로드하는 중 오류가 발생했습니다.');
            }, fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // Text(
        //   title,
        //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        // ),
      ]),
    );
  }
}
