class Currencies{
  String initials;
  String name;

  Currencies(this.initials, this.name);

  Currencies.fromJson(Map<String, dynamic> json) {
    initials = json['initials'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['initials'] = this.initials;
    data['name'] = this.name;
    return data;
  }
}