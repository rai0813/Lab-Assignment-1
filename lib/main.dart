import 'dart:convert';

//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key:key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key, }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

class _MyAppState extends State<MyApp> {
TextEditingController searchMovie = TextEditingController();
var movie = "";
var title="";
var year = "";
var actors = "";
var desc = "no records";
var plot = "";
var genre = "";
var posters =null; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Finder'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text("Enter your preferred movie"),
                TextField(controller: searchMovie),
                ElevatedButton(onPressed: _findMovie, child: const Text("Search")),
                Text(desc, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),  
              ],             
            ),
          ),
        ),
      ),
    );
  }


_findMovie() async{
 var apiid = "cb73ed83"; 

 var url = Uri.parse('http://www.omdbapi.com/?t=$title&apikey=cb73ed83');
 var response = await http.get(url);  
 var rescode = response.statusCode;
 if (rescode == 200) { 
    var jsonData = response.body;
    var parsedJson= json.decode(jsonData);

     setState((){
      title = parsedJson['Title'];
      year = parsedJson['Year'];
      actors = parsedJson['Actors'];
      posters = parsedJson['Poster'];
      plot = parsedJson['Plot'];
      genre = parsedJson['Genre'];

        desc= 
        "$posters\n Title: $title \n Genre: $genre \nYear released: $year \n Actors: $actors \n Plot: $plot";
      });
      Fluttertoast.showToast(
        msg: "Found",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    print(response.body);
    print(desc);
  }
  else {
    setState(() {
      print("no records");
    });
     setState(() {});
      Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
  }
  
}
}

void setState(Null Function() param0) {
}