import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(String isbn) async {
  final response = await http.get(Uri.parse(
      'https://openlibrary.org/api/books?bibkeys=ISBN:' +
          isbn +
          '&jscmd=data&format=json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // inspect(isbn);

    // Map tampung = json.decode(response.body) as Map;
    // inspect(tampung);
    // print(tampung["ISBN:0439139597"]["title"]);
    return Album.fromJson(jsonDecode(response.body)["ISBN:" + isbn]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Book');
  }
}

class Album {
  // final int userId;
  // final int id;
  final String title;
  final cover;
  // final authors;
  // final String title;

  Album(
      {
      // required this.userId,
      // required this.authors,
      required this.cover,
      required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      // userId: json["ISBN:0439139597"]["title"],
      // id: json["ISBN:0439139597"]["title"],
      // authors: json["authors"],
      title: json["title"],
      cover: json["cover"],
    );
  }
}

class DetailBook extends StatefulWidget {
  final String text;

  const DetailBook({Key? key, required this.text}) : super(key: key);

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            inspect(snapshot.data);
            if (snapshot.hasData) {
              return Column(
                children: [
                  Image.network(snapshot.data!.cover["medium"]),
                  Text(snapshot.data!.title),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                  'Info Buku belum tersedia, pastikan input NO ISBN dengan benar');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
