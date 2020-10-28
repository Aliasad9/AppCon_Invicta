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
      this.role,//dropdown menu
      this.companyName,//dropdown menu
      this.points,
      this.level,
      this.category1,
      this.category2,
      this.category3,
      this.category4,
      this.category5
      );
  Map<String, dynamic> toJson() =>
      {
        'name':this.name,
        'email':this.email,
        'imgUrl':this.imgUrl,
        'role':this.role,
        'companyName':this.companyName,
        'points':0,
        'level':1,
        'category1':0.0,
        'category2':0.0,
        'category3':0.0,
        'category4':0.0,
        'category5':0.0,
      };
}