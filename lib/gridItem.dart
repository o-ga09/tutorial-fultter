import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mhapp/const/const.dart';
import 'package:mhapp/detail.dart';
import './models/entity.dart';

class GridItem extends StatelessWidget {
  const GridItem ({Key? key, required this.entity}) : super(key: key);
  final Entity? entity;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if(entity != null) {
      return Column(
        children: [
          InkWell(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => Detail(entity: entity!),
                ),
              ),
            },
            child: Hero(
              tag: entity!.name,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: (TypeColors[entity!.types.first] ?? Colors.grey[100]),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                      entity!.imageUrl,
                    ),
                  ),
                ),
              ),
            ), 
          ),
          Text(
            entity!.name,
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return const SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Text('...'),
        ),
      );
    }
  }
}