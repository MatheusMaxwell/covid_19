
class Current{
  String id;
  String totalCases;
  String newCases;
  String totalDeaths;
  String totalRecovered;

  Current({this.id, this.totalCases, this.newCases, this.totalDeaths, this.totalRecovered});

  Current.fromMap(Map map):
      id = map['id'],
      totalCases = map['totalCases'] ?? '',
      newCases = map['newCases'] ?? '',
      totalDeaths = map['totalDeaths'] ?? '',
      totalRecovered = map['totalRecovered'] ?? '';

}