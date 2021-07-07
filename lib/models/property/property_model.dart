class PropertyModel {
  String name;
  String category;
  String address;
  String area;
  String thumbnail;
  String location;
  String price;
  String description;
  String hostId;
  String propertyId;

  PropertyModel({
    this.name,
    this.category,
    this.address,
    this.area,
    this.thumbnail,
    this.location,
    this.price,
    this.description,
    this.hostId,
    this.propertyId,
  });

  PropertyModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) {
      return;
    }

    name = json['productName'];
    category = json['productCategory'];
    address = json['productAddress'];
    area = json['productArea'];
    thumbnail = json['productThumbnail'];
    location = json['productLocation'];
    price = json['productPrice'];
    description = json['propertyDescription'];
    hostId = json['productAdminUserUID'];
    propertyId = json['propertyId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': name,
      'productCategory': category,
      'productAddress': address,
      'productArea': area,
      'productThumbnail': thumbnail,
      'productLocation': location,
      'productPrice': price,
      'propertyDescription': description,
      'productAdminUserUID': hostId,
      'propertyId': propertyId,
    };
  }
}
