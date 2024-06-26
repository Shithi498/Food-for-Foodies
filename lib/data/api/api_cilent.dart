import 'package:foodie/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String,String> _minHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl=appBaseUrl;
    timeout=Duration(seconds: 30);
    token=AppConstants.TOKEN;
    _minHeaders={
'Content-type':'applicatoon/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }

  void updateHeader(String token){
    _minHeaders={
      'Content-type':'applicatoon/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }

  Future<Response> getData(String uri,) async {
    try{
      Response response=await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }


   Future<Response> postData(String uri,dynamic body) async {
      try{
        Response response=await post(uri,body,headers:_minHeaders);
       // Response response=await post(uri,body,headers:_minHeaders);
        return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
    }
  }



