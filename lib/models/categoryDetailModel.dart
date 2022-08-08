class CategoryDetailModel{
  late bool status ;
  late CategoryDetailData data;
  CategoryDetailModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    data = CategoryDetailData.fromJson(json['data']);
  }

}

class CategoryDetailData{
  late int current_page;
  List<Data> productData = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;
  CategoryDetailData.fromJson(Map<String , dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element) {
      productData.add(Data.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];

  }
}

class Data{
late int id  ;
late int  discount ;
late dynamic price;
late dynamic oldPrice;
late String image;
late String name;
late String description;
late List<String> images;
late bool inFavorites;
late bool inCart;
Data.fromJson(Map<String , dynamic> json){
  id = json['id'];
  discount = json['discount'];
  price = json['price'];
  oldPrice = json['old_price'];
  image = json['image'];
  name = json['name'];
  description = json['description'];
  images = json['images'].cast<String>();
  inFavorites = json['in_favorites'];
  inCart = json['in_cart'];

}
}