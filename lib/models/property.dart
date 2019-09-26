import 'package:meta/meta.dart';

class property {
  final int externalId;
  final String pname;
  final String description;
  final String avatarUrl;
  final String location;
  final int preturn;
  final int mvalue;
  final int ovalue;
  final bool isCompleted;
  final List<String> pictures;
  final List<String> pattributes;

  property({
    @required this.externalId,
    @required this.pname,
    @required this.description,
    @required this.avatarUrl,
    @required this.location,
    @required this.preturn,
    @required this.mvalue,
    @required this.ovalue,
    @required this.isCompleted,
    @required this.pictures,
    @required this.pattributes,
  });

  @override
  String toString() {
    return "Cat $externalId is named $pname";
  }
}