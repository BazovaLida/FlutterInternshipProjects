import 'day_of_week.dart';
import 'task.dart';

class RecurringTask implements Task {
  late int _id;
  final String _name;
  final String _category;
  final DaysOfTheWeek _weekDay;

  RecurringTask(this._name, this._category, this._weekDay) {
    this._id = Task.setId();
  }

  @override
  int get id => _id;

  @override
  String get category => _category;

  @override
  String get name => _name;

  @override
  String toString() {
    var buffer = new StringBuffer('$_id\t${_weekDay.toShortString()} '
        'task "$_name" (category "$_category")');
    return buffer.toString();
  }
}
