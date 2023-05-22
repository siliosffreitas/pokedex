import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:pokedex/data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<dynamic> request({
    @required String url,
    @required String method,
    Map body,
    Map params,
    Map headers,
  }) async {
    final defaultHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
    }..addAll(headers?.cast<String, String>() ?? {});

    if (params?.isNotEmpty == true) {
      String suffixParams = '';
      params.forEach((key, value) {
        if (suffixParams.isNotEmpty) {
          suffixParams += '&';
        }
        suffixParams += '$key=$value';
      });
      url += '?$suffixParams';
    }

    var response = Response('', 500);
    try {
      if (method == 'get') {
        response = await client
            .get(url, headers: defaultHeaders)
            .timeout(Duration(seconds: 30));
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
