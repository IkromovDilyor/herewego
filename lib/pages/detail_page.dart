import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key}) : super(key: key);
 static final String id="detail_page";
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var titleController=TextEditingController();
  var contentController=TextEditingController();


  _addPost() async {

    String  title=titleController.text.toString();
    String content=contentController.text.toString();
    var userId =await Prefs.loadUserId();
    RTDBService.addPost(new Post (userId,  title, content));

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Post"),
      ),
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 15,),

              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title"
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                    hintText: "Content"
                ),
              ),
            SizedBox(height: 15,),
             Container(
               width: double.infinity,
               height: 45,
               child: FlatButton(
                 onPressed: _addPost,

                 color: Colors.blue,
                 child: Center(
                   child: Text("Add", style: TextStyle(color: Colors.white),),
                 ),
               ),
             )


            ],
          ),
        ),

      ),
    );
  }
}
