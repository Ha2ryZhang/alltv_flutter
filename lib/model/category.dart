class Category {
  int cid;
  String name;
  Category({
    this.cid,
    this.name,
  });
  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(
        cid: json["cid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "name": name,
      };
}