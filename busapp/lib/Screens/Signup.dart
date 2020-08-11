import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:busapp/models/driver_signup_model.dart';
import 'package:busapp/models/credentials.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'TripScreen.dart';
import '../services/driver_service.dart' as driverService;
import '../models/general_helper.dart' as hlp;

class SignUpPage extends StatefulWidget {
  static final String id = 'signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  File _image;
  bool _IdIsFound=false; //to check what kind of request we would do , post request or put request
   bool _isLoading = true;
    String _token;
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();

  //for storing of image
  final _firebaseStorage =
  FirebaseStorage(storageBucket: 'gs://kidzona-ed09b.appspot.com');
  StorageUploadTask _uploadTask;
  var _formKey = GlobalKey<FormState>();
DriverSignupModel driverModel = DriverSignupModel();

  void goToKidsListIfParentIdFound(http.Response response) {
    if (response.statusCode == 200) {
      var bodyMap = JsonDecoder().convert(response.body);
      Credentials.driverId = bodyMap["driverId"].toString();
     this._IdIsFound=true; //so we would make post request instead of post request
    }
      setState(() {
        this._isLoading = false;
      });
    
  }
 void submitForm() {
   print("offfffffff");
    this._formKey.currentState.save();
  print(this.driverModel.getFirstName());
  Function fun =driverService.signUp;
   setState(() {
      this._isLoading = true;
    });
if (this._IdIsFound ==true){
  fun =driverService.signUp;
}
    fun(this.driverModel, this._token).then((response) {
      setState(() {
        this._isLoading = false;
      });
    
      var bodyMap = JsonDecoder().convert(response.body);
      if (response.statusCode != 200) {
        hlp.showSimpleErrorMessage(bodyMap["message"], context);
      } else {
        Credentials.driverId = bodyMap["driverId"];
        Navigator.of(context).pushReplacementNamed(TripScreen.id);
      }
    }).catchError((err) {
      hlp.showSimpleErrorMessage("Unknown Error Heppened", context);
      setState(() {
        this._isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Driver app'),
        ),
        //resizeToAvoidBottomPadding: false,
        body: Center(
        child: Form(
          key: this._formKey,
          
          child: SingleChildScrollView(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "First Name"),
                  onSaved: (val) {
                    this.driverModel.setFirstName(val);
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(this._lastNameFocus);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Last Name",
                  ),
                  initialValue: this.driverModel.getLastName(),
                  focusNode: this._lastNameFocus,
                  onSaved: (val) {
                    this.driverModel.setLastName(val) ;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {

                    FocusScope.of(context)
                        .requestFocus(this._emailFocus);
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  initialValue: this.driverModel.getEmail(),
                  focusNode: this._emailFocus,
                  onSaved: (val) {
                    this.driverModel.setEmail(val) ;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {

                    FocusScope.of(context)
                        .requestFocus(this._emailFocus);
                  },
                ),
              
                    
                SizedBox(height: 10),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Pick an Image"),
                  onPressed: () async {
                    
                    File _image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                        
                    File _cropped = await ImageCropper.cropImage(
                        sourcePath: _image.path);
                        toolbarColor: Theme.of(context).primaryColor,
                        statusBarColor: Theme.of(context).primaryColor,
                        toolbarWidgetColor: Colors.white,
                        toolbarTitle: 'Crop It');
                    String path =
                        'images/${DateTime.now().toString()}.jpg';
                    _uploadTask = this
                        ._firebaseStorage
                        .ref()
                        .child(path)
                        .putFile(_cropped);
                    _uploadTask.onComplete.then((_) async {
                      this.driverModel.setPictureUrl(await this
                          ._firebaseStorage
                          .ref()
                          .child(path)
                          .getDownloadURL());
                      setState(() {});
                    });

                    setState(() {});
                  },
                ), 
            
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          submitForm();
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

/*
  void pickImage() async {
    //ImagePicker.pickImage(source: ImageSource.gallery);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this._image = image;
    });
  }
*/
  Widget buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget buildButtonContainer(String text) {
    return Container(
        height: 80.0,
        width: 160,
        color: Theme.of(context).primaryColor,
        child: Center(
            child: ButtonTheme(
          minWidth: 160,
          height: 80.0,
          child: RaisedButton(
            color: Colors.black,
            onPressed: null,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        )));
  }
}
