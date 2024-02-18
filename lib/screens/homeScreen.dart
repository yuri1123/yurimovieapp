import 'package:flutter/material.dart';
import 'package:yurimovieapp/models/comming_model.dart';
import 'package:yurimovieapp/models/now_model.dart';
import 'package:yurimovieapp/models/popular_model.dart';
import 'package:yurimovieapp/services/apiService.dart';
import 'package:yurimovieapp/widgets/commingMovie.dart';
import 'package:yurimovieapp/widgets/nowMovie.dart';
import 'package:yurimovieapp/widgets/popularMovie.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<PopularModel>> populars = ApiService.getPopularMovies();
  final Future<List<NowModel>> nows = ApiService.getNowMovies();
  final Future<List<CommingModel>> commings = ApiService.getCommingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.yellow,
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'POPULAR MOVIES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            FutureBuilder(
              future: populars,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      makePopularList(snapshot),
                    ],
                  );
                } else if (snapshot.hasError) {
                  // 에러가 발생한 경우 에러 메시지를 표시
                  return Center(
                    child: Text('에러 발생: ${snapshot.error}'),
                  );
                }
                // 데이터가 없는 경우 로딩 표시
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Text(
              'NOW IN CINEMAS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            FutureBuilder(
              future: nows,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      makeNowList(snapshot),
                    ],
                  );
                } else if (snapshot.hasError) {
                  // 에러가 발생한 경우 에러 메시지를 표시
                  return Center(
                    child: Text('에러 발생: ${snapshot.error}'),
                  );
                }
                // 데이터가 없는 경우 로딩 표시
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Text(
              'COMMING SOON',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            FutureBuilder(
              future: commings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      makeCommingList(snapshot),
                    ],
                  );
                } else if (snapshot.hasError) {
                  // 에러가 발생한 경우 에러 메시지를 표시
                  return Center(
                    child: Text('에러 발생: ${snapshot.error}'),
                  );
                }
                // 데이터가 없는 경우 로딩 표시
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}

Widget makePopularList(AsyncSnapshot<List<PopularModel>> snapshot) {
  return SizedBox(
    height: 250,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemBuilder: (context, index) {
        var popular = snapshot.data![index];
        return PopularMovie(
            title: popular.title, thumb: popular.thumb, id: popular.id);
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 20,
      ),
    ),
  );
}

Widget makeNowList(AsyncSnapshot<List<NowModel>> snapshot) {
  return SizedBox(
    height: 250,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemBuilder: (context, index) {
        var popular = snapshot.data![index];
        return NowMovie(
            title: popular.title, thumb: popular.thumb, id: popular.id);
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 20,
      ),
    ),
  );
}

Widget makeCommingList(AsyncSnapshot<List<CommingModel>> snapshot) {
  return SizedBox(
    height: 250,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemBuilder: (context, index) {
        var popular = snapshot.data![index];
        return CommingMovie(
            title: popular.title, thumb: popular.thumb, id: popular.id);
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 20,
      ),
    ),
  );
}
