import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Exchange {
  final String id;
  final String name;
  final String country;
  final String image;

  Exchange({this.id, this.name, this.country, this.image});

  factory Exchange.fromJson(Map<String, dynamic> json) {
    return Exchange(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      image: json['image'],
    );
  }
}

class ExchangeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Exchange>>(
      future: _fetchExchange(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Exchange> data = snapshot.data;
          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Exchange>> _fetchExchange() async {
    final jobsListAPIUrl = 'https://api.coingecko.com/api/v3/exchanges';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Exchange.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
              data[index].name, data[index].country, data[index].image);
        });
  }

  Card _tile(String name, String country, String image) => Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Image.network(
                  image,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    country??'Unknown',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
