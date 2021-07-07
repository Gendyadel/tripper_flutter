class FavourtieModel {
  String propertyId;
  bool isFavourite;

  FavourtieModel({
    this.propertyId,
    this.isFavourite,
  });

  FavourtieModel.fromJson({
    Map<dynamic, dynamic> json,
    String propertyID,
  }) {
    if (json == null) {
      return;
    }
//TODO edit 'productID' to propertyId

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
