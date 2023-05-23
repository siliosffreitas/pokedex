import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/entities/entities.dart';

class AbilityViewModel extends Equatable {
  final String name;

  AbilityViewModel({@required this.name});

  factory AbilityViewModel.fromEntity(AbilityEntity entity) =>
      AbilityViewModel(name: entity.name);

  List<Object> get props => [name];
}
