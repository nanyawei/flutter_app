// json转换辅助工厂， 把json转换为T
import 'package:dio/dio.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (json == null) {
      return null;
    }
    // // 这里可以加入温和需要并且可以转换的类型，例如
    // else if (T.toString() == 'LoginModel') {
    //   return LoginModel.fromJson(json) as T;
    // }
    else {
      return json as T;
    }
  }
}

class BaseEntity<T> {
  T data;

  BaseEntity({
    this.data
  });

  factory BaseEntity.fromJson(json) {
    return BaseEntity(
        data: EntityFactory.generateOBJ(json) );
  }
}

class BaseListEntity<T> {
  List<T> result;

  BaseListEntity({this.result});

  factory BaseListEntity.fromJson(json) {
    List<T> mData = new List<T>();

    if (json['result'] != null) {
      (json['result'] as List).forEach((v) {
        mData.add(EntityFactory.generateOBJ<T>(v));
      });
    }

    return BaseListEntity(result: mData);
  }
}

class ErrorEntity {
  int code;
  String message;
  ErrorEntity({this.code, this.message});
}

ErrorEntity createErrorEntity(DioError err) {
  switch (err.type) {
    case DioErrorType.CANCEL:
      {
        return ErrorEntity(code: -1, message: '请求取消');
      }
      break;
    case DioErrorType.CONNECT_TIMEOUT:
      {
        return ErrorEntity(code: -1, message: "连接超时");
      }
      break;
    case DioErrorType.SEND_TIMEOUT:
      {
        return ErrorEntity(code: -1, message: "请求超时");
      }
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      {
        return ErrorEntity(code: -1, message: "响应超时");
      }
      break;
    case DioErrorType.RESPONSE:
      {
        try {
          int errCode = err.response.statusCode;
          String errMsg = err.response.statusMessage;
          return ErrorEntity(code: errCode, message: errMsg);
//          switch (errCode) {
//            case 400: {
//              return ErrorEntity(code: errCode, message: "请求语法错误");
//            }
//            break;
//            case 403: {
//              return ErrorEntity(code: errCode, message: "服务器拒绝执行");
//            }
//            break;
//            case 404: {
//              return ErrorEntity(code: errCode, message: "无法连接服务器");
//            }
//            break;
//            case 405: {
//              return ErrorEntity(code: errCode, message: "请求方法被禁止");
//            }
//            break;
//            case 500: {
//              return ErrorEntity(code: errCode, message: "服务器内部错误");
//            }
//            break;
//            case 502: {
//              return ErrorEntity(code: errCode, message: "无效的请求");
//            }
//            break;
//            case 503: {
//              return ErrorEntity(code: errCode, message: "服务器挂了");
//            }
//            break;
//            case 505: {
//              return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
//            }
//            break;
//            default: {
//              return ErrorEntity(code: errCode, message: "未知错误");
//            }
//          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      }
      break;
    default:
      {
        return ErrorEntity(code: -1, message: err.message);
      }
  }
}
