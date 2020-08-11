class Stop {
  final int stopId;
  final String location;
  final String expTime;
  final String actTime;
  final int kidId;

  const Stop(
      {this.stopId, this.location, this.expTime, this.actTime, this.kidId});

  factory Stop.fromMap(Map<String, dynamic> map) {
    return Stop(
      stopId: map['stopId'] as int,
      location: map['location'] as String,
      expTime: map['exp_time'] as String,
      actTime: map['act_time'] as String,
      kidId: map['kidId'] as int,
    );
  }

  static List<Stop> stopList(List data) =>
      data.map<Stop>((e) => Stop.fromMap(e)).toList();
}
