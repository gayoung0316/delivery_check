import 'dart:convert';

Delivery deliveryFromJson(String str) => Delivery.fromJson(json.decode(str));

String deliveryToJson(Delivery data) => json.encode(data.toJson());

class Delivery {
  Delivery({
    required this.from,
    required this.to,
    required this.state,
    required this.progresses,
    required this.carrier,
  });

  From from;
  From to;
  Stat state;
  List<Progress> progresses;
  Carrier carrier;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        from: From.fromJson(json["from"]),
        to: From.fromJson(json["to"]),
        state: Stat.fromJson(json["state"]),
        progresses: List<Progress>.from(
            json["progresses"].map((x) => Progress.fromJson(x))),
        carrier: Carrier.fromJson(json["carrier"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from.toJson(),
        "to": to.toJson(),
        "state": state.toJson(),
        "progresses": List<dynamic>.from(progresses.map((x) => x.toJson())),
        "carrier": carrier.toJson(),
      };
}

class Carrier {
  Carrier({
    required this.id,
    required this.name,
    required this.tel,
  });

  String id;
  String name;
  String tel;

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
        id: json["id"],
        name: json["name"],
        tel: json["tel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tel": tel,
      };
}

class From {
  From({
    required this.name,
    required this.time,
  });

  String name;
  DateTime time;

  factory From.fromJson(Map<String, dynamic> json) => From(
        name: json["name"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time.toIso8601String(),
      };
}

class Progress {
  Progress({
    required this.time,
    required this.status,
    required this.location,
    required this.description,
  });

  DateTime time;
  Stat status;
  Location location;
  String description;

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        time: DateTime.parse(json["time"]),
        status: Stat.fromJson(json["status"]),
        location: Location.fromJson(json["location"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "status": status.toJson(),
        "location": location.toJson(),
        "description": description,
      };
}

class Location {
  Location({
    required this.name,
  });

  String name;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Stat {
  Stat({
    required this.id,
    required this.text,
  });

  String id;
  String text;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}
