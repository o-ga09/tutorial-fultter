import 'package:flutter/material.dart';
import 'package:mhapp/models/favorite.dart';
import 'package:provider/provider.dart';
import './models/entity.dart';
import 'const/const.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key, required this.entity}) : super(key: key);
  final Entity entity;
  @override
  Widget build(BuildContext context) {
      return Consumer<FavoriteNotifier>(
        builder: (context,favs,child) => 
          Scaffold(
            body: Container(
              color: (TypeColors[entity.types.first] ?? Colors.grey[100])
                ?.withOpacity(.5),
              child: SafeArea(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 上下中央寄せ
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      trailing: IconButton( 
                        icon: favs.isExist(entity.id)
                          ? const Icon(Icons.star,color: Colors.orangeAccent)
                          : const Icon(Icons.star),
                        onPressed: () => {
                          favs.toggle(Favorite(entityId: entity.id))
                        }
                      )
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          child: Hero(
                            tag: entity.name,
                            child: Container(
                              height: 280,
                              width: 280,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.circular(180),
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                    entity.imageUrl,
                                  )
                                ),
                              ), 
                            ),
                          ), 
                        ),
                      ],
                    ),
                    Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.white.withOpacity(.5),
                          ),
                          child: Text(
                          '#${entity.id.toString().padLeft(3,"0")}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      '${entity.name.substring(0,1).toUpperCase()}${entity.name.substring(1)}',
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: entity.types
                      .map(
                        (type) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Chip(
                            backgroundColor: Colors.yellow,
                            label: Text(
                              type,
                              style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: (TypeColors[type] ?? Colors.grey).computeLuminance() > 0.5
                                      ? Colors.black  
                                      : Colors.white
                                  ),
                                ),
                              ),
                            )
                          )
                          .toList(),
                        ),
                        const Spacer(),
                        ],
                      ),
                    ),
                ),
                ),
              );
    // Helloworld
    // return const Scaffold(
    //   body: Center(
    //     child: Text(
    //       'Hello World',
    //       style: TextStyle(
    //         fontSize: 36,
    //       ),
    //     ),
    //   ),
    // );
  }
}