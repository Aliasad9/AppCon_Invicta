class CustomUser {
  String name;
  String email;
  String imgUrl;
  String role;
  String companyName;
  int points;
  int level;
  int category1;
  int category2;
  int category3;
  int category4;
  int category5;

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
        category1 = json['category1'],
        category2 = json['category2'],
        category3 = json['category3'],
        category4 = json['category4'],
        category5 = json['category5'];

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
