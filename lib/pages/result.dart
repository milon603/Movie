import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List> searchMovie({String? query}) async {
  var res = await http
      .get(Uri.parse("https://imdb-api.com/API/Search/k_7a5d7x6o/$query"));
  if (res.statusCode == 200) {
    var movie = jsonDecode(res.body)["results"];
    return movie;
  } else
    throw Exception("Error loading data...");
}

class result extends StatefulWidget {
  const result({
    Key? key,
    required String? this.search_Q,
  }) : super(key: key);
  final String? search_Q;

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  late Future<List> movie;

  void initState() {
    super.initState();
    movie = searchMovie(query: widget.search_Q!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.search_Q!),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
            future: movie,
            builder: (context, AsyncSnapshot<List> sn) {
              if (sn.hasData) {
                List? movies = sn.data;
                return ListView.builder(
                  itemCount: movies!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(movies[i]["image"]),
                      ),
                      title: Text(movies[i]["title"]),
                      subtitle: Text(movies[i]["description"]),
                    );
                  },
                );
                //return Text(movies!.length.toString());
              } else if (sn.hasError) return Text("data loading fail...");
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
