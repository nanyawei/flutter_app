export './account.dart';

class Api {
  static final baseApi = ''; //ip地址
}

enum Method {
  GET,
  POST,
  PATCH,
  PUT
}

const methodValues = {
  Method.GET: 'get',
  Method.POST: 'post',
  Method.PATCH: 'patch',
  Method.PUT: 'put'
};

