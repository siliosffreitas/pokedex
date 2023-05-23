import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

class TypeModel {
  final int order;
  final String name;

  TypeModel({
    @required this.order,
    @required this.name,
  });

  factory TypeModel.fromJson(Map json) {
    return TypeModel(
      name: json['type']['name'],
      order: json['slot'],
    );
  }

  TypeEntity toEntity() => TypeEntity(
        name: name,
        order: order,
      );
}
