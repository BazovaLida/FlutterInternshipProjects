import 'dart:io';

import 'plain_task.dart';
import 'recurring_task.dart';
import 'day_of_week.dart';
import 'to_do_list.dart';

// starts testing of the project and console communication
main() {
  ToDoList toDoList = initialToDoList();
  print("Initial state of to-do list:");
  print(toDoList);
  presentList(toDoList);

  var input;
  do {
    stdout.writeln('Do you want to change the list?(0 - no, 1 - make '
        'a new list, 2 - modify current, 3 - show categorised list)\n');
    input = stdin.readLineSync();
    switch (input) {
      case "1":
        toDoList = makeNewList();
        break;
      case "2":
        modifyList(toDoList);
        break;
      case "3":
        presentList(toDoList);
        break;
    }
  } while (input != "0");
  print("Testing is successfully completed!");
}

// make an initial to-do list
ToDoList initialToDoList() {
  return ToDoList(iterableElements: [
    PlainTask("task1", "cat1"),
    RecurringTask("name2", "cat2", DaysOfTheWeek.Monday),
    RecurringTask("name3", "cat3", DaysOfTheWeek.Friday),
    PlainTask("name4", "cat2"),
    PlainTask("name5", "cat2"),
    PlainTask("name6", "cat1")
  ]);
}

// making a new empty to-do list and
ToDoList makeNewList() {
  ToDoList list = ToDoList();
  print("Empty to-do list was made");
  return list;
}

// console communication for modifying list
void modifyList(ToDoList list) {
  var input;
  do {
    stdout.writeln('Type 0 to stop modification\n'
        '\t1 to remove element from list;\n'
        '\t2 to add element to the list.');
    input = stdin.readLineSync();
    switch (input) {
      case "1":
        removeElement(list);
        break;
      case "2":
        addElement(list);
        break;
    }
    print(list);
  } while (input != "0");
}

// removes an element of the list if list contains this element
void removeElement(ToDoList list) {
  if (list.isEmpty()) {
    print("No element to remove");
  } else {
    stdout.writeln('Removing mode. Type id of element');
    list.removeById(getIntInput());
  }
}

// adding element to the list with a help of console communication
void addElement(ToDoList list) {
  print("Adding new element...");

  stdout.writeln("Type task's name");
  var name = stdin.readLineSync();

  stdout.writeln("Type task's category");
  var category = stdin.readLineSync();

  stdout.writeln("Is the task recurring? (1 - yes)");
  int answer = getIntInput();
  if (answer == 1) {
    stdout.writeln("Type day of the day of week");
    var day = DaysOfTheWeek.values[stdin.readByteSync()];
    list.add(RecurringTask(name!, category!, day));
  } else {
    list.add(PlainTask(name!, category!));
  }
}

// safe parsing an int from console input
int getIntInput() {
  int answer;
  try {
    answer = int.parse(stdin.readLineSync()!);
  } on FormatException {
    answer = -1;
  }
  return answer;
}

// generate categorised representation of the list and print it
void presentList(ToDoList list) {
  list.generateCategorised();
  print("Categorized view of this list:\n${list.categorisedToString()}\n");
}
