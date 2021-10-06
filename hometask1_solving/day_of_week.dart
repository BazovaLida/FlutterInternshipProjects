enum DaysOfTheWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

extension ParseToString on DaysOfTheWeek {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
