class AppUser {
  // User Object.
  final String? name;
  final String? surname;
  final String? email;
  final String? password;
  final String? university;
  final String? fieldOfStudy;
  final String? yearOfStudy;
  String? imgURL;
  int hexPoints = 0;

  AppUser({
    this.name,
    this.surname,
    this.email,
    this.password, // Bunu silebiliriz
    this.university,
    this.fieldOfStudy,
    this.yearOfStudy,
  });
  @override
  String toString() {
    return ("Name: $name\nSurname: $surname\nemail: $email\npassword: $password\nUniversity: $university\nField: $fieldOfStudy\nyearOfStudy: $yearOfStudy");
  }
}
