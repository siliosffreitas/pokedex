import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TypeEntity extends Equatable {
  final int order;
  final String name;

  TypeEntity({@required this.order, @required this.name});

  List<Object> get props => [order, name];
}
