import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/univhex_post.dart';

class Constants {
  static const List<String> schools = <String>[
    "TED UNIVERSITY",
    "BASKENT UNIVERSITY",
    "ATILIM UNIVERSITY"
  ];

  static const List<String> fields = <String>[
    "Computer Engineering",
    "Industrial Engineering",
    "Architecture",
  ];
  static const List<String> years = <String>[
    "1",
    "2",
    "3",
    "4",
  ];

  static AppUser TestUser = AppUser(
    // For Testing the app without any authentication
    email: "test@tedu.edu.tr",
    fieldOfStudy: "Computer Engineering",
    name: "Name",
    surname: "Surname",
    password: "Test",
    university: "TED University",
    yearOfStudy: "4",
  );
  static UnivhexPost TestPost = UnivhexPost(
      postedBy: TestUser,
      textContent: "Lorem ipsum...\nLoremiosuahfqlçsiclaöi",
      isAnonymous: false);
}
