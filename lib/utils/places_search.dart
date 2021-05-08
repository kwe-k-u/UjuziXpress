
class PlaceSearch{
  String name;
  String placeId;


  PlaceSearch({this.name, this.placeId});

  factory PlaceSearch.fromJson(Map<String, dynamic> map){
    return PlaceSearch(
      name: map["description"],
      placeId: map["place_id"]
    );
  }

}