import 'package:meta/meta.dart';

class property {
  final int externalId;
  final String name;
  final String description;
  final String avatarUrl;
  final String location;
  final int likeCounter;
  final bool isAdopted;
  final List<String> pictures;
  final List<String> cattributes;

  property({
    @required this.externalId,
    @required this.name,
    @required this.description,
    @required this.avatarUrl,
    @required this.location,
    @required this.likeCounter,
    @required this.isAdopted,
    @required this.pictures,
    @required this.cattributes,
  });

  @override
  String toString() {
    return "Cat $externalId is named $name";
  }
}