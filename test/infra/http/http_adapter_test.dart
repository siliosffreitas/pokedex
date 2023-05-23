import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/infra/http/http.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    url = faker.internet.httpUrl();
    sut = HttpAdapter(client);
  });

  group('shared', () {
    test('Should throw ServerError if invalid method is provided', () async {
      final future = sut.request(url: url, method: 'invalid_method');
      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('get', () {
    PostExpectation mockRequest() => when(client.get(
          any,
          headers: anyNamed('headers'),
        ));

    void mockResponse(int statusCode,
            {String body = '{"any_key":"any_value"}'}) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception);

    setUp(() {
      mockResponse(200);
    });

    test('should call get with correct values', () async {
      await sut.request(url: url, method: 'get');

      verify(client.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ));

      await sut.request(
          url: url, method: 'get', headers: {'any_header': 'any_value'});

      verify(client.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'any_header': 'any_value',
        },
      ));

      await sut.request(
          url: url,
          method: 'get',
          headers: {'any_header': 'any_value'},
          params: {});

      verify(client.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'any_header': 'any_value',
        },
      ));

      await sut.request(
          url: url,
          method: 'get',
          headers: {'any_header': 'any_value'},
          params: null);

      verify(client.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'any_header': 'any_value',
        },
      ));

      await sut
          .request(url: url, method: 'get', params: {'any_param': 'any_value'});

      verify(client.get(
        '$url?any_param=any_value',
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ));

      await sut.request(
          url: url,
          method: 'get',
          params: {'any_param1': 'any_value', 'any_param2': 'any_value'});

      verify(client.get(
        '$url?any_param1=any_value&any_param2=any_value',
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ));
    });

    test('should return data if get returns 200', () async {
      final response = await sut.request(url: url, method: 'get');
      expect(response, {'any_key': 'any_value'});
    });

    test('should return null if get returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'get');
      expect(response, null);
    });

    test('should return null if get returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'get');
      expect(response, null);
    });

    test('should return null if get returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'get');
      expect(response, null);
    });

    test('should return BadRequestError if get returns 400 with no data',
        () async {
      mockResponse(400, body: '');

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('should return BadRequestError if get returns 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('should return UnauthorizedError if get returns 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.unauthorized));
    });

    test('should return forbiddenError if get returns 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.forbidden));
    });

    test('should return NotFoundError if get returns 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.notFound));
    });

    test('should return ServerError if get returns 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.serverError));
    });

    test('should return ServerError if get throws', () async {
      mockError();

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.serverError));
    });
  });
}
