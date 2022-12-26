import 'package:univhex/Objects/app_user.dart';

class UnivhexPost {
  final AppUser? postedBy;
  final String textContent;
  final bool isAnonymous;
  int hexes = 0;
  UnivhexPost({
    required this.postedBy,
    required this.textContent,
    required this.isAnonymous,
  });
}
