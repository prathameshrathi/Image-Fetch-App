import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'screens/error.dart';
import 'widgets/imageview.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = true, errorLoading = false;
  var pageNumber = 1;
  List<String> paths = [];
  ScrollController scrollController = new ScrollController();

  Future<void> getData(int page) async {
    var url = Uri.parse(
        "https://api.unsplash.com/photos?client_id=Yj_6mpCDE2lwxMesk0HoD5Uy8uWdEKWWqG9QSbOTKbM&page=$page");
    Response response;
    response = await get(url);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      setState(() {
        loading = false;
        //print(page);
        for (var i = 0; i < decoded.length; i++) {
          paths.add(decoded[i]["urls"]["regular"]);
        }
      });
    } else {
      setState(() {
        errorLoading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      try {
        getData(pageNumber);
      } catch (e) {
        print("error");
        print(e);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          loading = true;
        });
        Timer(Duration(seconds: 3), () {
          pageNumber++;
          getData(pageNumber);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Task"),
        ),
        body: errorLoading
            ? ErrorScreen()
            : SafeArea(
                child: loading && paths.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Text("Image source: Unsplash API"),
                          Expanded(
                            child: ListView.builder(
                                physics: loading
                                    ? NeverScrollableScrollPhysics()
                                    : null,
                                controller: scrollController,
                                itemCount: paths.length,
                                itemBuilder: (context, index) {
                                  return ImageView(paths[index]);
                                }),
                          ),
                          Visibility(
                            visible: loading,
                            child: Stack(
                              children: const [
                                Positioned(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }
}
