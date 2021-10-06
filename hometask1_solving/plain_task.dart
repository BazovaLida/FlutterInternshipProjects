import 'task.dart';

class PlainTask implements Task {
  late int _id;
  final String _name;
  final String _category;

  PlainTask(this._name, this._category) {
    this._id = Task.setId();
  }

  @override
  int get id => this._id;

  @override
  String get category => _category;

  @override
  String get name => _name;

  @override
  String toString() {
    var buffer =
        new StringBuffer('$_id\tPlain task "$_name" (category "$_category")');
    return buffer.toString();
  }
}
