class SwimLog {
  final DateTime date;
  final bool didSwim;
  final String message;

  SwimLog({
    required this.date,
    required this.didSwim,
    required this.message,
  });

  factory SwimLog.fromMap(Map<String, dynamic> map) {
    return SwimLog(
      date: DateTime.parse(map['date']),
      didSwim: map['didSwim'],
      message: map['message'],
    );
  }
}
