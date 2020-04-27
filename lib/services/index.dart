import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_console/page/login/index.dart';
import 'package:flutter_console/services/entity.dart';
import 'package:flutter_console/services/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
export './util.dart';
export './account.dart';
export './oa.dart';

typedef void ChildContext(BuildContext context);

Future<String> authorizationToken() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  final String headerToken = _prefs.getString('headerToken');
  String tokenJWT = 'Bearer $headerToken';
  return tokenJWT;
}

class TokenInterceptor extends Interceptor {
  BuildContext context;

  @override
  Future onRequest(RequestOptions options) async {

    String fullPath = options.baseUrl + options.path;

    if (options.method == 'GET' && options.queryParameters.length > 0) {
      List params = [];
      options.queryParameters.forEach((k, v) => params.add('$k=$v'));
      fullPath += '?' + params.join('&').toString();
      print('fullPath:::: $fullPath');
    }
    options.headers['authorization'] = await authorizationToken();
    return super.onRequest(options);
  }

  @override
  onError(DioError error) async {
    // 401 代表token过期
    Dio dio = HttpUtil._dio;
    dio.lock(); //加锁
    if (error.response != null && error.response.statusCode == 401) {
      getToken();
    }
    dio.unlock(); // 解锁
    super.onError(error);
  }

  Future getToken() async {
    String tokenJWT = await authorizationToken();
    Dio tokenDio = Dio();
    tokenDio.options.headers['authorization'] = tokenJWT;

    try {
      var response = await tokenDio.get(accountService['my']);
      sendResponse(response);
    } on DioError catch (e) {
      print('response: token: $e');
      if (e.response.statusCode == 401) {
        //401代表refresh_token过期
        return Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => LoginPage())); //refreshToken过期，弹出登录页面
      }
    }
  }
}

/*
 * 设置token，检查每条结果更新token
 * res 请求返回结果
 */
Future sendResponse(Response res) async {
  if (res.headers['authorization'] != null) {
    final String token = res.headers['authorization'][0];
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('headerToken', token);
  }
}

class HttpUtil {

  static final HttpUtil _shared = HttpUtil._internal();
  factory HttpUtil() => _shared;

  static Dio _dio;

  HttpUtil._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
          baseUrl: Api.baseApi,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          receiveDataWhenStatusError: false,
          connectTimeout: 30000,
          receiveTimeout: 3000);
      _dio = Dio(options)..interceptors.add(TokenInterceptor());
    }
  }

  static final _fetchTypes = <String, Function>{
    'post': _dio.post,
    'put': _dio.put,
    'patch': _dio.patch,
    'delete': _dio.delete,
    'head': _dio.head
  };

  static Future<dynamic> get (url, {Map<String, dynamic> data}) async {
    return await _fetch('get', url, data);
  }
  static Future<dynamic> post (url, {Map<String, dynamic> data}) async {
    return await _fetch('post', url, data);
  }
  static Future<dynamic> put (url, {Map<String, dynamic> data}) async {
    return await _fetch('put', url, data);
  }
  static Future<dynamic> patch (url, {Map<String, dynamic> data}) async {
    return await _fetch('patch', url, data);
  }
  static Future<dynamic> delete (url, {Map<String, dynamic> data}) async {
    return await _fetch('delete', url, data);
  }
  static Future<dynamic> head (url, {Map<String, dynamic> data}) async {
    return await _fetch('head', url, data);
  }
  

  static Future<dynamic> getList (url, {Map<String, dynamic> data}) async {
    return await _fetchList('get', url, data);
  }
  static Future<dynamic> postList (url, {Map<String, dynamic> data}) async {
    return await _fetchList('post', url, data);
  }
  static Future<dynamic> putList (url, {Map<String, dynamic> data}) async {
    return await _fetchList('put', url, data);
  }
  static Future<dynamic> patchList (url, {Map<String, dynamic> data}) async {
    return await _fetchList('patch', url, data);
  }
  static Future<dynamic> deleteList (url, {Map<String, dynamic> data}) async {
    return await _fetchList('delete', url, data);
  }
  static Future<dynamic> headList (url, {Map<String, dynamic> data}) async {
    return await _fetchList('head', url, data);
  }

  static Future<dynamic> _fetch (method, url, data) async {
    try {
      final Response response = method == 'get' ?
        await _dio.get(url, queryParameters: data) :
        await _fetchTypes[method](url, data: data);

        if (response != null) {
          print('----------------- response -------------');
          sendResponse(response);
          BaseEntity entity = BaseEntity.fromJson(response.data);
          if (entity != null) {
            return entity.data;
          } else {
            return ErrorEntity(code: -1, message: '数据请求成功，但是发生了一点问题🙅‍♂️，请稍后...');
          }
        }
    } on DioError catch(e) {
      final error = e.response != null && e.response.statusCode == 403 ?
        e.response.data :
        {"message": "服务器繁忙，请稍后再试！", "code": 1001};

      // showTip(error['message']);

      throw(error);
    }
  }
  static Future<dynamic> _fetchList (method, url, data) async {
    try {
      final Response response = method == 'get' ?
        await _dio.get(url, queryParameters: data) :
        await _fetchTypes[method](url, data: data);

        if (response != null) {
          print('----------------- response -------------');
          sendResponse(response);
          BaseListEntity entity = BaseListEntity.fromJson(response.data);
          if (entity != null && entity.result.length >= 0) {
            return entity.result;
          } else {
            return ErrorEntity(code: -1, message: '数据请求成功，但是发生了一点问题🙅‍♂️，请稍后...');
          }
        }
    } on DioError catch(e) {
      final error = e.response != null && e.response.statusCode == 403 ?
        e.response.data :
        {"message": "服务器繁忙，请稍后再试！", "code": 1001};
      // showTip(error['message']);

      throw(error);
    }
  }
}
