import 'dart:convert';
import 'dart:io';

import 'package:Invicta/data/user.dart';
import 'package:Invicta/screens/navigation_screen.dart';
import 'package:Invicta/widgets/heading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:shared_preferences/shared_preferences.dart';

class ExtraInfoScreen extends StatefulWidget {
  final email;
  final companiesList;
  final rolesList;

  ExtraInfoScreen(this.email, this.companiesList, this.rolesList);

  @override
  _ExtraInfoScreenState createState() => _ExtraInfoScreenState();
}

class _ExtraInfoScreenState extends State<ExtraInfoScreen> {
  final databaseReference = FirebaseFirestore.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CustomUser user = new CustomUser();
  TextEditingController _textEditingController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _companies;

  List<DropdownMenuItem<Company>> _dropdownMenuItemscompanies;
  Company _selectedCompany;

  var _roles;

  List<DropdownMenuItem<Role>> _dropdownMenuItemsroles;
  Role _selectedRole;

  File _image;

  @override
  void initState() {
    _companies = this.widget.companiesList;
    _roles = this.widget.rolesList;
    _dropdownMenuItemscompanies = buildDropdownMenuItemscompany(_companies);
    _selectedCompany = _dropdownMenuItemscompanies[0].value;
    _dropdownMenuItemsroles = buildDropdownMenuItemsrole(_roles);
    _selectedRole = _dropdownMenuItemsroles[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Role>> buildDropdownMenuItemsrole(roles) {
    List<DropdownMenuItem<Role>> items = [];
    for (var role in roles) {
      if (role.companyName == _selectedCompany.name)
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

  List<DropdownMenuItem<Company>> buildDropdownMenuItemscompany(companies) {
    List<DropdownMenuItem<Company>> items = [];
    for (var company in companies) {
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
      _dropdownMenuItemsroles = buildDropdownMenuItemsrole(_roles);
      _selectedRole = _dropdownMenuItemsroles[0].value;
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
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _textEditingController,
        validator: (value) {
          if (value.isEmpty) {
            return ("Field cannot be empty");
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
      ),
    );
  }

  _imgFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  _imgFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  Widget _buildSelectedImage() {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _image != null
                ? CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(
                      _image,
                    ),
                  )
                : Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black38),
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
              _image != null
                  ? Container()
                  : Text(
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
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FlatButton(
                  onPressed: () {
                    _showPicker(context);
                  },
                  child: Center(
                    child: _image != null
                        ? Text(
                            "Change Image",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                              fontSize: 10,
                            ),
                          )
                        : Text(
                            "Upload Image",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                              fontSize: 10,
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              if (_image != null) {
                showAlertDialog(context);
                await _uploadImage();
                this.user.email = this.widget.email;
                this.user.name = _textEditingController.text;
                this.user.companyName = _selectedCompany.name;
                this.user.role = _selectedRole.name;
                await databaseReference.collection("users").add(user.toJson());
                final appDir = await syspath.getApplicationDocumentsDirectory();
                final fileName = Path.basename(_image.path);
                final savedImage =
                    await _image.copy('${appDir.path}/$fileName');
                final SharedPreferences prefs = await _prefs;
                prefs.setString('email', user.email);
                prefs.setString('name', user.name);
                prefs.setString('imgUrl', savedImage.path);
                prefs.setString('role', user.role);
                prefs.setString('companyName', user.companyName);
                prefs.setInt('points', 0);
                prefs.setInt('level', 1);
                prefs.setInt('category1', 0);
                prefs.setInt('category2', 0);
                prefs.setInt('category3', 0);
                prefs.setInt('category4', 0);
                prefs.setInt('category5', 0);
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => NavigationScreen(savedImage.path, this.user.companyName)),
                    (route) => false);
              } else {
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: Text('Select your profile photo'),
                ));
              }
            }
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

  _uploadImage() async {
    String link = '';
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_images/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;

    storageReference.getDownloadURL().then((fileURL) {
      link = fileURL;
      print(link);
      setState(() {
        this.user.imgUrl = fileURL; //TODO: imgUrl Not storing in firebase
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                "Getting things ready...",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);
}

class Role {
  int id;
  String name;
  String companyName;

  Role();

  Role.name(this.id, this.name, this.companyName);
}
