import 'package:http/http.dart';
import 'package:pokedex/data/http/http.dart';
import 'package:pokedex/infra/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}
