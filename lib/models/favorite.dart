import 'package:flutter/material.dart';
import 'package:mhapp/db/favorite.dart';

class Favorite {
  final int entityId;
  
  Favorite({
    required this.entityId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': entityId
    };
  }
}

class FavoriteNotifier extends ChangeNotifier {
  final List<Favorite> _favs = [];

  List<Favorite> get favs => _favs;

  void toggle(Favorite favs) {
      if(isExist(favs.entityId)) {
        delete(favs.entityId);
      } else {
        add(favs);
      }
    }

  bool isExist(int id) {
    if(_favs.indexWhere((fav) => fav.entityId == id) < 0) {
      return false;
    } else {
      return true;
    }
  }

  void syncDB() {
    Favoritedb.Read().then(
      (val) => _favs
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }

  void add(Favorite fav) async {
    await Favoritedb.Create(fav);
    syncDB();
  }

  void delete(int id) async {
    await Favoritedb.Delete(id);
    syncDB();
  }
}