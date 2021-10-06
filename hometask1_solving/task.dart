abstract class Task {
  int get id;
  String get category;
  String get name;

  static int idCount = 0;

  static int setId() {
    return idCount++;
  }
}
