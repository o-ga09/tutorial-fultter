import 'package:flutter/material.dart';
import '../api/get.dart';

class EntityNotifier extends ChangeNotifier {
  final Map<int,Entity?> _Entity = {};

  Map<int,Entity?> get entities => _Entity;

  void addEntity(Entity e) {
    _Entity[e.id] = e;
    notifyListeners();
  }

  void fetchAPI(int id) async {
    _Entity[id] = null;
    addEntity(await fetchEntity(id));
  }

  Entity? byId(int id) {
    if(!_Entity.containsKey(id)) {
      fetchAPI(id);
    }

    return _Entity[id];
  }
}

class Entity {
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;

  Entity({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    List<String> typesToList(dynamic types) {
      List<String> ret = [];
      for (int i = 0; i < types.length; i++) {
        ret.add(types[i]['type']['name']);
      }
      return ret;
    }

    return Entity(
      id: json['id'],
      name: json['name'],
      types: typesToList(json['types']),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}