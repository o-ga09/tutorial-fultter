import 'package:flutter/material.dart';
import './detail.dart';
import './models/entity.dart';
import './const/const.dart';

class ListItems extends StatelessWidget {
  const ListItems({Key? key, required this.entity}) : super(key: key);
  final Entity? entity;
  @override
  Widget build(BuildContext context) {
    if(entity != null) {
      return ListTile(
      leading: Hero(
        tag: entity!.name,
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            color: (TypeColors[entity!.types.first] ?? Colors.grey[100])
                    ?.withOpacity(.3),
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
      title: Text(
        entity!.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        entity!.types.first,
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Detail(entity: entity!,),
            ),
          ),
        },
      );
    } else {
      return const ListTile(title: Text('...'));
    }
  }
}