import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

class TypeViewModel extends Equatable {
  final String name;
  final int order;

  TypeViewModel({
    @required this.name,
    @required this.order,
  });

  factory TypeViewModel.fromEntity(TypeEntity entity) => TypeViewModel(
        name: entity.name,
        order: entity.order,
      );

  List<Object> get props => [name, order];
}
