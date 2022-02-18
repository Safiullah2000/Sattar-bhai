import 'dart:convert';

import 'package:apiproject/api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ApiModel> getData() async {
    var response = await http.get(Uri.parse(
        "http://165.227.69.207/rehmat-e-sheree/public/api/products/hashlob/web-data/products/get/all/auth"));
    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return ApiModel.fromJson(data);
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ApiModel>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data!.data![index].name!),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
