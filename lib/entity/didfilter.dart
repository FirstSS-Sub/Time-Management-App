import 'package:time_management_app/entity/models.dart';




extension DidFilters on List<Did>{

 List<Did> FilterByType(int typeid){
    return this.where((element) => element.type == typeid).toList();
    
  }

}