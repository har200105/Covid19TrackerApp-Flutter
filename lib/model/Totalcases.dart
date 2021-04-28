class Total {
  int cases;
  int deaths;
  int recovered;
  Total({this.cases,this.deaths,this.recovered});
  factory Total.fromJson(final json){

  return Total(cases: json['cases'],deaths: json['deaths'],recovered: json['recovered']);
}
}