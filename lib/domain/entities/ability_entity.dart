import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AbilityEntity extends Equatable {
  final String name;

  AbilityEntity({@required this.name});

  List<Object> get props => [name];
}
