
class Country{

  String id;
  String country;
  String totalCases;
  String newCases;
  String totalDeaths;
  String totalRecovered;
  String activeCases;
  String criticalCases;
  String totalCasesPerMillion;
  String totalDeathsPerMillion;
  int version;

  Country({this.id, this.country, this.totalCases, this.newCases, this.totalDeaths, this.totalRecovered, this.activeCases,
    this.criticalCases, this.totalCasesPerMillion, this.totalDeathsPerMillion, this.version});

  Country.fromMap(Map map):
      id = map['id'] ?? '',
      country = map['country'] ?? '',
      totalCases = map['totalCases'] ?? '',
      newCases = map['newCases'] ?? '',
      totalDeaths = map['totalDeaths'] ?? '',
      totalRecovered = map['totalRecovered'] ?? '',
      activeCases = map['activeCases'] ?? '',
      criticalCases = map['criticalCases'] ?? '',
      totalCasesPerMillion = map['totalCasesPerMillion'] ?? '',
      totalDeathsPerMillion = map['totalDeathsPerMillion'] ?? '',
      version = map['__v'] ?? '';
}