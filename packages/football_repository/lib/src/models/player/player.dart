import 'package:equatable/equatable.dart';

class BasicPlayerInfo extends Equatable {
  BasicPlayerInfo({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [
    id,
    name,
  ];
}