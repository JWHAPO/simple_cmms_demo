class WorkOrder{
  String workOrderId;
  String workOrderDesc;
  String startDate;
  String endDate;

  WorkOrder({this.workOrderId, this.workOrderDesc, this.startDate, this.endDate});

  WorkOrder.fromJson(Map json)
  :
        workOrderId = json['workOrderId'],
        workOrderDesc = json['workOrderDesc'],
        startDate = json['startDate'],
        endDate = json['endDate'];

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['workOrderId'] = workOrderId;
    map['workOrderDesc'] = workOrderDesc;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
  }

}