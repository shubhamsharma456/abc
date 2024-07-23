import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDemo extends StatefulWidget {
  const ApiDemo({super.key});

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {


  List<Photos> photolist = [];


 Future<List<Photos>> getPhotos () async{

   try{
    var  response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url']);
        photolist.add(photos);
      }
      return photolist;

    }
    else{
      return photolist;
    }
   }catch(e){
     return [];
   }

  }

  MapBase<String, dynamic> ? dataMap;
  MapBase<String, dynamic> ? doneDataMap;
 List<dynamic> ?doneListData;
  Future hitApi() async {
    http.Response response;
    response =  await http.get(Uri.parse('https://dummyjson.com/products'));

    if(response.statusCode==200){
      setState(() {
        dataMap= jsonDecode(response.body);
        doneListData = dataMap!["products"];
        print(doneListData);
      });

    }
  }
  //fetch
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);

    } else {
      throw Exception('Failed to load data');
    }
  }

  //Post
  Future<void> createData() async {
    final response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': 'Flutter HTTP CRUD',
          'body': 'This is a blog post about HTTP CRUD methods in Flutter',
          'userId': 1,
        }));

    if (response.statusCode != 201) {
      throw Exception('Failed to create data');
    }
  }

  //put
  Future<void> updateData(int id) async {
    final response = await http.put(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': 'Flutter HTTP CRUD',
          'body': 'This is an updated blog post about HTTP CRUD methods in Flutter',
          'userId': 1,
        }));

    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }

  //delt
  Future<void> deleteData(int id) async {
    final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

 //POSt METhod
 postData() async{
   try{
     var response = await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
         body: {"id":1.toString(),"name":"Shubham"});
     print(response.body);
   }catch(e){
     print(e);
   }
 }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hitApi();
    postData();


    fetchData();
    deleteData(1);


  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Column(children: [
        Expanded(child:  photolist==null ? const CupertinoActivityIndicator():

        FutureBuilder(future: getPhotos(),builder: (context, AsyncSnapshot<List<Photos>> snapshoot){
          return ListView.builder(itemCount:photolist.length, itemBuilder: (context,index){
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(snapshoot.data![index].url.toString()),),
                title: Text(snapshoot.data![index].title.toString()),
            );
          });
        },))
      ],),
    );




    //   Center(
    //   child: doneListData==null ? CupertinoActivityIndicator():
    //     ListView.builder(itemCount:doneListData!.length ,itemBuilder: (context,index){
    //   return ListTile(
    //     title: Text(doneListData![index]["title"].toString()),
    //     subtitle: Text(doneListData![index]["category"].toString()),
    //   );
    //   }),
    // );
  }
}
class Photos{
  String title ,url ;
  Photos({required this.title,required this.url});
}