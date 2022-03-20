import 'dart:convert';

import 'package:api_integration/Models/UserModels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserApiTest extends StatefulWidget {
  const UserApiTest({Key? key}) : super(key: key);

  @override
  State<UserApiTest> createState() => _UserApiTestState();
}

class _UserApiTestState extends State<UserApiTest> {
  List<UserModels> userList = [];
  Future<List<UserModels>> createPhotosApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModels.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Api Test"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: createPhotosApi(),
                builder: (context, AsyncSnapshot<List<UserModels>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                 ReuseableRow(title: "Name", value: snapshot.data![index].name.toString()),
                                 ReuseableRow(title: "Phone", value: snapshot.data![index].phone.toString()),
                                 ReuseableRow(title: "Email", value: snapshot.data![index].email.toString()),
                                 ReuseableRow(title: "Email", value: snapshot.data![index].address!.geo!.lat.toString()),
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
class ReuseableRow extends StatelessWidget {
  final title, value;
 ReuseableRow({Key? key, required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}
