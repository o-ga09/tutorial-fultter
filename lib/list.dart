import './list_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/entity.dart';
import './const/const.dart';
import './modal.dart';
import 'models/favorite.dart';

class EntityList extends StatefulWidget {
  const EntityList({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ListState createState() => _ListState();
}

class _ListState extends State<EntityList> {
  static const int pageSize = 30;
  bool isFavoriteMode = false;
  int _currentPage = 1;

  bool isLastPage(int favcount,int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favcount) {
        return false;
      }
      return true;
    } else {
      if (_currentPage * pageSize < MaxId) {
        return false;
      }
      return true;
    }
  }

  int itemCount(int favcount, int page) {
    int ret = page * pageSize;
    if(isFavoriteMode && ret > favcount) {
      ret = favcount;
    }

    if(ret > MaxId) {
      ret = MaxId;
    }

    return ret;
  }

  int itemId(List<Favorite> favs, int index) {
    int ret = index + 1;
    if(isFavoriteMode && index < favs.length) {
      ret = favs[index].entityId;
    }
    return ret;
  }

  void changeMode(bool currentMode) {
    setState(() => isFavoriteMode = !currentMode);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteNotifier>(
      builder: (context,favs,child) => Column(
        children: [
          Container(
            height: 24,
            alignment: Alignment.topRight,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: isFavoriteMode 
                ? const Icon(Icons.auto_awesome_outlined,color:Colors.orangeAccent)
                : const Icon(Icons.auto_awesome_outlined),
              onPressed: () async {
                var ret = await showModalBottomSheet<bool>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Modal(
                      favMode: isFavoriteMode,
                    );
                  },
                );
                if (ret != null && ret) {
                  changeMode(isFavoriteMode);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<EntityNotifier>(
              builder: (context, entity, child) {
                if (itemCount(favs.favs.length, _currentPage) == 0) {
                  return const Text('no data');
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount(favs.favs.length, _currentPage)) {
                        return OutlinedButton(
                          child: const Text('more'),
                          onPressed: isLastPage(favs.favs.length, _currentPage)
                              ? null
                              : () => {
                                    setState(() => _currentPage++),
                                  },
                        );
                      } else {
                        return ListItems(
                          entity: entity.byId(itemId(favs.favs, index)),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}