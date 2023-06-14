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
          body: SafeArea(
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
                      child: Image.network(
                        entity.imageUrl,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                      'No.${entity.id}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  entity.name,
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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