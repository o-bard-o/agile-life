DateTime stripTime(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

bool isSameDate(DateTime left, DateTime right) {
  return left.year == right.year &&
      left.month == right.month &&
      left.day == right.day;
}

int differenceInCalendarDays(DateTime from, DateTime to) {
  return stripTime(from).difference(stripTime(to)).inDays.abs();
}
