abstract class Task {
  int get id;
  String get category;
  String get name;

  // static variable to count task's id
  static int idCount = 0;

  // static method for setting an unique id for task
  static int setId() {
    return idCount++;
  }
}
