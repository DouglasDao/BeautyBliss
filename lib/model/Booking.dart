class Booking {

  final String brideName, eventType, receptionDateTime, weddingDateTime, otherEventDateTime, receptionMonth, weddingMonth, otherEventMonth, venue, hairStylist, description;

  final int packageCost, advanceAmount;

  Booking({this.brideName,
      this.eventType,
      this.receptionDateTime,
      this.receptionMonth,
      this.weddingDateTime,
      this.weddingMonth,
      this.otherEventDateTime,
      this.otherEventMonth,
      this.venue,
      this.packageCost,
      this.advanceAmount,
      this.hairStylist,
      this.description});

  factory Booking.fromJson(Map<String, dynamic> data) => new Booking(
      brideName: data["brideName"],
      eventType: data["eventType"],

      receptionDateTime: data["receptionDateTime"],
      receptionMonth: data["receptionMonth"],
      weddingDateTime: data["weddingDateTime"],
      weddingMonth: data["weddingMonth"],

      otherEventDateTime: data["otherEventDateTime"],
      otherEventMonth: data["otherEventMonth"],

      venue: data["venue"],
      packageCost: data["packageCost"],
      advanceAmount: data["advanceAmount"],
      hairStylist: data["hairStylist"],
      description: data["description"]);

  Map<String, dynamic> toMap() {
    return {
      'brideName': brideName,
      'eventType': eventType,
      'receptionDateTime': receptionDateTime,
      'receptionMonth': receptionMonth,
      'weddingDateTime': weddingDateTime,
      'weddingMonth': weddingMonth,
      'otherEventDateTime': otherEventDateTime,
      'otherEventMonth': otherEventMonth,
      'venue': venue,
      'packageCost': packageCost,
      'advanceAmount': advanceAmount,
      'hairStylist': hairStylist,
      'description': description,
    };
  }
}
