import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/views/articles.dart';

class CategoryNews extends StatefulWidget {

  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar :AppBar(
        title: Text('News feed'),
        elevation: 0.0,
      ),
      body: loading ? Center(
        child: Container(

          child:CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
       child : Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16),
              child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index){
                  return NewsTile(
                    imageUrl: articles[index].urlToImage,
                    title:  articles[index].title,
                    desc:  articles[index].description,
                    url: articles[index].url,
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

class NewsTile extends StatelessWidget {


  final String imageUrl,title,desc,url;

  const NewsTile({@required this.imageUrl,@required this.title,@required this.desc, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(
          blogUrl: url,
        )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8),
            Text(title,style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 8),
            Text(desc,style: TextStyle(
                color: Colors.black54
            ),),

          ],
        ),
      ),
    );
  }
}


