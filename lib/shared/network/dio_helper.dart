import 'package:dio/dio.dart';


//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

class DioHelper
{
  static Dio? dio ;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
        // validateStatus: (statusCode)
        // {
        //   if(statusCode == null){
        //     return false;
        //   }
        //   if(statusCode == 526)
        //   { // your http status code
        //     return true;
        //   }else{
        //     return statusCode >= 200 && statusCode < 300;
        //   }
        // },
      ),
    );
  }

  static Future<Response> getData({
  required String url,
  required Map<String,dynamic> query,
}) async
  {
    return await dio!.get(url, queryParameters: query,);
  }
}