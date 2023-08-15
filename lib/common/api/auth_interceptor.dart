import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String _userId;
  final String _appId;

  AuthInterceptor(this._userId, this._appId);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['Ignore-Auth'] != null) {
      options.headers.remove('Ignore-Auth');
      return super.onRequest(options, handler);
    }
    options.headers['Authorization'] = 'Virtru [["$_appId","$_userId"]]';
    super.onRequest(options, handler);
  }
}
