class Quotes {
  String initials;
  num value;

  Quotes(this.initials, this.value);

  Quotes.fromJson(Map<String, dynamic> json) {
    initials = json['initials'];
    value = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['initials'] = this.initials;
    data['value'] = this.value;
    return data;
  }
}