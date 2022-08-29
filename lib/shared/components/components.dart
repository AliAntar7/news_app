import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/waitting_screen.dart';
import 'package:news_app/pages/web_view_screen.dart';


Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  required String label,
  required IconData prefix,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  String? Function(String?)? validate,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
        prefix,
    ),
    border: OutlineInputBorder(),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(2.0),
  child:   Container(
    height: 2,
    color: Colors.grey[200],
  ),
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: ()
  {
    navigateTo(context, webViewScreen(article['url']),);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: article['urlToImage'] != null ? NetworkImage(
                '${article['urlToImage']}',
              ) :
              NetworkImage(
                  'https://www.pngitem.com/pimgs/m/572-5724817_flat-warning-icon-png-transparent-png.png'
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch? const Wait() : const Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget) => Navigator.push(
    context, MaterialPageRoute(
    builder: (context) => widget,
),
);


