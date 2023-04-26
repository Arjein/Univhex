import 'package:univhex/Objects/app_user.dart';

class UnivhexPost {
  final AppUser? postedBy;
  final String textContent;
  final bool isAnonymous;
  final DateTime dateTime;
  List hexedBy = [];
  Map<AppUser, String> commentBy = {};
  UnivhexPost({
    required this.postedBy,
    required this.textContent,
    required this.isAnonymous,
    required this.dateTime,
  });
}
