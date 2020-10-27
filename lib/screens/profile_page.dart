import 'package:Invicta/widgets/heading.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
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
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              role.name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'OpenSans',
                fontSize: 13,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItemscompany(
      List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              company.name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'OpenSans',
                fontSize: 13,
              ),
            ),
          ),
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
      shadowColor: Colors.black45,
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
      shadowColor: Colors.black45,
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
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .merge(TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return ("Please provide a valid name");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 16),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      //keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildSelectedImage() {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black38),
              child: Icon(
                Icons.photo_camera_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "No image selected",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 20,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FlatButton(
                  onPressed: null,
                  child: Center(
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF),
                          fontSize: 10),
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
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32, left: 6, right: 6),
      child: Container(
        width: double.maxFinite,
        height: 42,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, "");
          },
          child: Text(
            "Update Profile",
            style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Heading("Set up the Profile!"),
                ),
                _buildSubHeading("Name"),
                _buildTextField(),
                _buildSubHeading("Select Profile Image"),
                _buildSelectedImage(),
                _buildSubHeading("Company Name"),
                _buildDropDowncompany(),
                _buildSubHeading("Your Role"),
                _buildDropDownrole(),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
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
      Role(1, "Manager"),
      Role(2, "Front-End"),
      Role(3, "Backend"),
      Role(4, "TeamLead"),
    ];
  }
}
