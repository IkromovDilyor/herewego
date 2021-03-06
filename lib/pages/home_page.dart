import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/rtdb_service.dart';

class HomePage extends StatefulWidget {
  static final String id = 'home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _apiGetPosts();
  }

  _apiGetPosts() async {
    var id = await Prefs.loadUserId();

    RTDBService.getPosts(id).then((posts) => {
      _respPost(posts),
    });
  }

  _respPost(List<Post> posts) {
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('All Posts', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
            Prefs.removeUserId();
            Navigator.pushReplacementNamed(context, SignInPage.id);
          }),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return _itemBuilder(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: _openDetail,
      ),
    );
  }

  Widget _itemBuilder(Post post) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: post.img_url != null ?
            Image.network(post.img_url, fit : BoxFit.cover) :
            Image.asset('assets/images/ic_default.png'),
          ),

          SizedBox(height: 10,),

          Text(post.lastname + ' ' + post.firstname, style: TextStyle(fontSize: 22),),
          SizedBox(height: 5,),
          Text(post.date),
          SizedBox(height: 5,),
          Text(post.content),
        ],
      ),
    );
  }

  _openDetail() async {
    Map result = await Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) {
          return new DetailPage();
        }
    ));

    if (result != null && result.containsKey('data')) {
      print(result['data']);
      _apiGetPosts();
    }
  }
}
