class Equipment{
  String equipId;
  String equipNo;
  String equipDesc;
  String eqLocDesc;


  Equipment({this.equipId, this.equipNo, this.equipDesc, this.eqLocDesc});

  Equipment.fromJson(Map json)
  :
        equipId = json['equipId'],
        equipNo = json['equipNo'],
        equipDesc = json['equipDesc'],
        eqLocDesc = json['eqLocDesc'];

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['equipId'] = equipId;
    map['equipNo'] = equipNo;
    map['equipDesc'] = equipDesc;
    map['eqLocDesc'] = eqLocDesc;
  }
}