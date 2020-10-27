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
      this.category5);
}