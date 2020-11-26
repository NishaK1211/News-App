
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/categoryList.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/articles.dart';
import 'package:news_app/views/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool loading= true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();

  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News feed'),
        elevation: 0.0,
      ),
      body: loading ? Center(
        child: Container(

          child:CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
           child: Column(
            children: [
              //categories
              Container(

                height: 70.0,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TileView(
                        imageUrl: categories[index].imageAssetUrl,

                        categoryName: categories[index].categorieName,
                      );
                    }),
              ),


              //articles
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
              )],
          ),
        ),
      ),
    );
  }
}

class TileView extends StatelessWidget {
  final String imageUrl, categoryName;
  TileView({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder :(context) => CategoryNews(
              category: categoryName.toLowerCase(),
            ),
        ));

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),

              child: CachedNetworkImage(
                imageUrl :
                imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              width: 120,
              height: 60,


              child: Text(categoryName,style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),),
            ),

          ],
        ),
      ),
    );
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

