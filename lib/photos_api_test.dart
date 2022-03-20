import 'dart:convert';

import 'package:api_integration/Models/PhotosModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosApiTest extends StatefulWidget {
  const PhotosApiTest({Key? key}) : super(key: key);

  @override
  State<PhotosApiTest> createState() => _PhotosApiTestState();
}

class _PhotosApiTestState extends State<PhotosApiTest> {
  List<PhotosModels> photosList = [];
  Future<List<PhotosModels>> createPhotosApi() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photosList.add(PhotosModels.fromJson(i));
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos Api Test"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: createPhotosApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("Loading");
                  } else {
                    return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4.0,
                            shadowColor: Colors.blueGrey,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: Text(photosList[index].title.toString()),
                                    subtitle: Text(photosList[index].thumbnailUrl.toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                            photosList[index]
                                                .url
                                                .toString())
                                    ),
                                  ),

                // *************Showing photos horizontally using container*************

                                  /*Container(
                                    height: MediaQuery.of(context).size.height *
                                        .15,
                                    width:
                                        MediaQuery.of(context).size.width*.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                photosList[index]
                                                    .url
                                                    .toString()))),
                                  )*/
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
