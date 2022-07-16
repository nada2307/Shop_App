class CategoriesModel{
  late bool status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{
  late int current_page;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String , dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add( DataModel.fromJson( element));
    });

  }

}

class DataModel{
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}