import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_fetch_data_imdb/constraints.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// var data=;
  var requiredData;
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 55, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    top: 5,
                    left: 10,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () async {
                      print("Clicked on Search Button");
                      print("Search Movie: $name");
                      var url = Uri.parse("$baseUrl/$name");
                      try {
                        final response = await http.get(url);
                        print(response);
                        final responseData = json.decode(response.body);
                        print("Response Data $responseData");
                        setState(() {
                          requiredData = responseData["results"];
                        });

                        print("Requried Data : $requiredData");
                        print("Title: ${requiredData[5]["title"]}");
                      } catch (error) {
                        throw (error);
                      }
                      print("Length: ${requiredData.length}");
                    },
                    color: Colors.black,
                  ),
                  hintText: "Search Here",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 0),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 180,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Image.network(
                              requiredData != null
                                  ? "${requiredData[index]["image"]}"
                                  : "https://m.media-amazon.com/images/M/MV5BOWM4ZmJhMTctZWI3NC00ODJiLWI1MGUtYjM3NTVmYzY0OTFlXkEyXkFqcGdeQXVyMTEzNzg0Mjkx._V1_Ratio0.7273_AL_.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    requiredData != null
                                        ? "${requiredData[index]["title"]}"
                                        : "Title",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  requiredData != null
                                      ? "${requiredData[index]["description"]}"
                                      : "Description",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "7.5 IMDB",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
