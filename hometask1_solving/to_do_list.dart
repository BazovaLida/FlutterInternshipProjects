import 'task.dart';

class ToDoList {
  late final List<Task> _tasks;
  // categorised version of the list (key: category, value: listed tasks of that category
  late Map<String, List<Task>> _categorised;

  // constructor that can get initialised element or iterable collection of elements
  ToDoList({
    Task? element,
    Iterable<Task>? iterableElements,
  }) {
    _tasks = [if (element != null) element, ...?iterableElements];
  }

  void add(Task task) {
    _tasks.add(task);
  }

  void addAll(
    Iterable<Task> tasks,
  ) {
    tasks.forEach((task) {
      add(task);
    });
  }

  void removeById(int id) {
    return _tasks.removeWhere((element) => element.id == id);
  }

  // generation of categorised version. Saving and returning it
  Map generateCategorised() {
    _categorised = {};

    _tasks.forEach((element) {
      if (_categorised[element.category] == null) {
        _categorised[element.category] = [element];
      } else {
        _categorised[element.category]!.add(element);
      }
    });

    return _categorised;
  }

  // returns formatted [_categorised].
  String categorisedToString() {
    final buffer = StringBuffer();
    var iterator = _categorised.entries.iterator;
    while (iterator.moveNext()) {
      buffer.write("\t${iterator.current.key}\n");

      iterator.current.value.forEach((element) {
        buffer.write("\t-\t${element.name}\n");
      });
    }
    return buffer.toString();
  }

  bool isEmpty() {
    return _tasks.isEmpty;
  }

  @override
  String toString() {
    final buffer = StringBuffer("To-Do list contains:\n");
    buffer.writeAll(_tasks, "\n");
    return buffer.toString();
  }
}
