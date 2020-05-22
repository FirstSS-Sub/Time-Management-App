import 'package:time_management_app/entity/models.dart';



extension DidFilters on List<Did>{
  //TypeIDでフィルタ
 List<Did> filteredByType(int typeid){
    return this.where((element) => element.type == typeid).toList();  
  }
  //TypeIdで分類
  Map<int,List<Did>> groupedByType(){
    Map<int,List<Did>> result = new Map<int,List<Did>>();
    
    this.forEach((element) { 
      if(!result.containsKey(element.type))
        result[element.type] = new List<Did>();
      result[element.type].add(element);
    });
    return result;
  }
  //指定区間と被るものを抽出
  List<Did> filteredBySpan(DateTime start,DateTime end){
    return this.where((element) =>  element.hasCommon(start, end)).toList();    
  }
  //指定区間と被った区間の経過時間を抽出
  List<Duration> getCommonSpans(DateTime start,DateTime end){
    return this.map((e) => e.commonRange(start, end)).toList();
  }
  //経過時間を抽出
  List<Duration> getSpans(){
    return this.map((e) => e.start.difference(e.end)).toList();
  }

}