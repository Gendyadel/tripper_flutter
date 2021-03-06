class FavourtieModel {
  String propertyId;
  bool isFavourite;

  FavourtieModel({
    this.propertyId,
    this.isFavourite = false,
  });

  FavourtieModel.fromJson({
    Map<dynamic, dynamic> json,
    String propertyID,
  }) {
    if (json == null) {
      return;
    }

    propertyId = propertyID;
    isFavourite = json['isFavourite'];
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'productID': propertyId,
      'isFavourite': isFavourite,
    };
  }
}
