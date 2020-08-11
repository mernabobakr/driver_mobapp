import './Stop.dart';

class Trip {
  final int driverId;
  final String date;
  final String status;
  final List<Stop> stops;

  const Trip({this.driverId, this.date, this.status, this.stops});

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      driverId: map['driverId'] as int,
      date: map['date'] as String,
      status: map['status'] as String,
      stops: Stop.stopList(map['stops'] ?? []),
    );
  }

  static List<Trip> tripList(List data) =>
      data.map<Trip>((e) => Trip.fromMap(e)).toList();
}
