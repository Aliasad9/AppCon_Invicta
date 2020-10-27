import 'package:flutter/material.dart';
import 'package:uiauth/heading.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItemscompanies;
  Company _selectedCompany;



  List<Role> _roles = Role.getRoles();
  List<DropdownMenuItem<Role>> _dropdownMenuItemsroles;

  Role _selectedRole;




  @override
  void initState() {
    _dropdownMenuItemsroles = buildDropdownMenuItemsrole(_roles);
    _dropdownMenuItemscompanies = buildDropdownMenuItemscompany(_companies);
    _selectedRole = _dropdownMenuItemsroles[0].value;
    _selectedCompany = _dropdownMenuItemscompanies[0].value;
    super.initState();
  }







  List<DropdownMenuItem<Role>> buildDropdownMenuItemsrole(List roles) {
    List<DropdownMenuItem<Role>> items = List();
    for (Role role in roles) {
      items.add(
        DropdownMenuItem(
          value: role,
          child: Text(role.name),
        ),
      );
    }
    return items;
  }
















  List<DropdownMenuItem<Company>> buildDropdownMenuItemscompany(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemcompany(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }



  onChangeDropdownItemrole(Role selectedRole) {
    setState(() {
      _selectedRole = selectedRole;
    });
  }















  _buildDropDowncompany() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: _selectedCompany,
          items: _dropdownMenuItemscompanies,
          onChanged: onChangeDropdownItemcompany,
        ),
      ),
    );
  }



  _buildDropDownrole() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: _selectedRole,
          items: _dropdownMenuItemsroles,
          onChanged: onChangeDropdownItemrole,
        ),
      ),
    );
  }

















  _buildSubHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1.merge(
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7))),
      ),
    );
  }
  Widget _buildTextField(){
    return TextFormField(
      validator: (value) {
        if (value.isEmpty ) {
          return ("Please provide a valid name");
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Your Name",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      //keyboardType: TextInputType.emailAddress,

    );

  }



  Widget _buildSelectedImage(){
    return Container(
      child: Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/a.jpg")),
              borderRadius: BorderRadius.all(Radius.circular(126.0)),

            ),
          ),
          SizedBox(width: 5,),
          Column(
            children: [
              Text("No image selected",
              style: TextStyle(
                fontSize: 16,

                fontWeight: FontWeight.w400,
                color: Color(0xFF575757),
              ),),
              SizedBox(height: 1,),
              ButtonTheme(
                minWidth: 20,
                height: 30,
                child: RaisedButton(onPressed: null,
                  child:  Container(
                    decoration: BoxDecoration(
                      color: Color(0x6A6A6A),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 112,
                    height: 19,
                    child: Center(
                      child: Text(
//change the color contrast here
                        "Upload Image",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,

                            color:  Color(0xFFFFFFFF),

                            fontSize: 15
                        ),
                      ),
                    ),
                  ),


                ),
              ),
            ],
          )
        ],
      ),

    );
  }












  _buildButton() {
    return RaisedButton(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blue,
      onPressed: () {
        Navigator.pushNamed(context,"");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Update Profile",
            style: TextStyle(color: Colors.white,
            fontWeight:FontWeight.w600,
            fontSize: 18),
          ),

        ],
      ),
    );
  }



























  Widget _buildScreenUI(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Heading("Set up the Profile!"),
          SizedBox(height: 10,),
          _buildTextField(),
          SizedBox(height: 10),
          _buildSubHeading("Company Name"),
          _buildDropDowncompany(),
          _buildSubHeading("Select Profile Image"),
          _buildSelectedImage(),
          _buildSubHeading("Your Role"),
          _buildDropDownrole(),
          SizedBox(height: 10,),
          _buildButton(),




        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Invicta',
            style: TextStyle(color: Colors.black),
          ),
          leading: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(left: 140, right: 10),
                width: 65,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  backgroundImage: ExactAssetImage('images/a.jpg'),
                ),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: Colors.blueAccent,
                    width: 4.0,
                  ),
                ),
              ),
            )
          ],
        ),
        body: _buildScreenUI(context),

    ) ;
  }
}
class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'AlphaBolt'),
      Company(2, 'Traverse'),
      Company(3, 'Google '),
      Company(4, 'Facebook'),
      Company(5, 'Microsoft'),
    ];
  }
}
class Role {
  int id;
  String name;

  Role(this.id, this.name);

  static List<Role> getRoles() {
    return <Role>[
     Role(1,"Manager"),
      Role(2,"Front-End"),
      Role(3,"Backend"),
      Role(4,"TeamLead"),
    ];
  }
}


