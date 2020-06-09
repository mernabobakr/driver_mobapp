  import './Stop.dart';

class trip{
  String driverId;
  String date;
  String status;
  List<Stop> stops;
  trip(this.driverId,this.date,this.status,var stop){
this.stops=stop;
  }
  // trip(this.driverId,this.date,this.status,this.stops);
}