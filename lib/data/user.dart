class CustomUser {
  String name;
  String email;
  String imgUrl;
  String role;
  String companyName;
  int points;
  int level;
  double category1;
  double category2;
  double category3;
  double category4;
  double category5;

  CustomUser();

  CustomUser.name(
      this.email,
      this.name,
      this.imgUrl,
      this.role,
      this.companyName,
      this.points,
      this.level,
      this.category1,
      this.category2,
      this.category3,
      this.category4,
      this.category5);

  CustomUser.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        imgUrl = json['imgUrl'],
        role = json['role'],
        companyName = json['companyName'],
        points = json['points'],
        level = json['level'],
        category1 = (json['category1']).toDouble(),
        category2 = (json['category2']).toDouble(),
        category3 = (json['category3']).toDouble(),
        category4 = (json['category4']).toDouble(),
        category5 = (json['category5']).toDouble();

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'email': this.email,
        'imgUrl': this.imgUrl,
        'role': this.role,
        'companyName': this.companyName,
        'points': 0,
        'level': 1,
        'category1': 0,
        'category2': 0,
        'category3': 0,
        'category4': 0,
        'category5': 0,
      };
}
