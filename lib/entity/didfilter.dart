import 'package:time_management_app/entity/models.dart';



extension DidFilters on List<Did>{
  //TypeIDでフィルタ
  List<Did> filteredByType(int typeid){
    return this.where((element) => element.type == typeid).toList();
  }




  //期間内の分類された総計を返す
  Map<int,Duration> groupByTypeAndGetCommonAmount(DateTime start,DateTime end){
    var filtered = this.filteredBySpan(start, end);
    var grouped = filtered.groupedByType();
    var result = grouped.map((key, value) => new MapEntry(key,value.getCommonSpans(start, end).reduce((value, element) => value+element)));
    return result;    
  }
  //すべての機関の分類された総計を返す
  Map<int,Duration> grooupByTypeAndGetAmount(){
    var start = this.map((e) => e.start).reduce((value, element) => 
    value.isBefore(element) ? value : element   
    );
    var end = this.map((e) => e.end).reduce((value, element) => 
    value.isAfter(element) ? value : element
    );
    return this.groupByTypeAndGetCommonAmount(start, end);

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
  //年で絞り込み
  List<Did> getYearSpan(int year){
    var start = new DateTime(year);

    var end = new DateTime(year+1).subtract(new Duration(microseconds:1));
    return this.filteredBySpan(start, end);
  }
  //月で絞り込み
  List<Did> getMonthSpan(int year,int month){
    var start = new DateTime(year ,month,1);
    if (month == 12){
      year += 1;
      month = 1;
    }
    var end = new DateTime(year,month,1).subtract(new Duration(microseconds:1));
    return this.filteredBySpan(start, end);
  }
  //日で絞り込み
  List<Did> getDaySpan(int year,int month,int day){
    var start = new DateTime(year ,month,day);
    var end = start.add(new Duration(days:1)).subtract(new Duration(microseconds:1));
    return this.filteredBySpan(start, end);
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