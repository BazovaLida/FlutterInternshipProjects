enum DaysOfTheWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

// prints short version of the DaysOfTheWeek's element
extension ParseToString on DaysOfTheWeek {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
