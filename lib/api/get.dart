import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/entity.dart';
import '../const/const.dart';

Future<Entity> fetchEntity(int id) async {
  final res = await http.get(Uri.parse('$ApiRoute/pokemon/$id'));
  if (res.statusCode == 200) {
    return Entity.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Pokemon');
  }
}