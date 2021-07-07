import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/services/auth_service.dart';

class HomePage extends StatefulWidget {
  static String id="home_page";
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>items=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  items.add(new Post("123", "title", "content"));
    items.add(new Post("123", "title", "content"));
    items.add(new Post("123", "title", "content"));
  }
  _openDetail(){
    Navigator.popAndPushNamed(context, DetailPage.id);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text("All Posts"),
        actions: [
          IconButton(
            onPressed: (){
              AuthService.signOutUser(context);
            },
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
          )
          ,
        ],
      ),
      body: ListView.builder(
       itemCount: items.length,
        itemBuilder: (ctx, i){
         return _itemOfPost(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _openDetail();

        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
  Widget _itemOfPost(Post post){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title,style: TextStyle(color: Colors.black,fontSize: 20),),
          SizedBox(height: 10,),
          Text(post.content,style: TextStyle(color: Colors.black,fontSize: 16),)
        ],
      ),
    );
  }


}
