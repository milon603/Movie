import 'package:flutter/material.dart';
import 'package:movie/pages/result.dart';

class jomePage extends StatelessWidget {
  TextEditingController searchText = TextEditingController();

  jomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Finder'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: searchText,
            ),
            ElevatedButton(
              onPressed: () {
                // print(searchText.text);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => result(search_Q: searchText.text)));
              },
              child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
