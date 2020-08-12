import 'dart:convert';
import 'dart:io';

import 'package:busapp/models/credentials.dart';
import 'package:busapp/models/driver_signup_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/general_helper.dart' as hlp;
import '../services/driver_service.dart' as driverService;
import 'TripScreen.dart';

class SignUpPage extends StatefulWidget {
  static final String id = 'signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  File image;
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
/*
  void goToTripsIfDriverIdFound(http.Response response) {
    if (response.statusCode == 200) {
      var bodyMap = JsonDecoder().convert(response.body);
      Credentials.driverId = bodyMap["iddrivers"].toString();
    }
    setState(() {
      this._isLoading = false;
    });
  }
*/
  void submitForm() {
    print("offfffffff");
    this._formKey.currentState.save();
    print(this.driverModel.getFirstName());
    print(this.driverModel.getLastName());
    print(this.driverModel.getEmail());
    // print(this.driverModel.getPictureUrl());

    setState(() {
      // this._isLoading = true;
    });

    driverService.signUp(this.driverModel).then((response) {
      print("The status code is  ");
      print(response.statusCode);
      setState(() {
        // this._isLoading = false;
      });

      var bodyMap = JsonDecoder().convert(response.body);

      if (response.statusCode != 200) {
        hlp.showSimpleErrorMessage(bodyMap["message"], context);
        print("The message is " + bodyMap["message"]);
      } else {
        Credentials.driverId = bodyMap["iddrivers"];
        Credentials.driverId = bodyMap["first_name"];
        Credentials.driverId = bodyMap["last_name"];
        Credentials.email = bodyMap["email"];
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
      body:
          /*this._isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : */
          Form(
        key: this._formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              //you can customize its size as you want OR you can remove it too :D
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: image == null
                    ? CircleAvatar(
                        radius: 50,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.person, color: Color(0xFF21BFBD)),
                          iconSize: 45,
                        ),
                      )
                    : Image.file(
                        image,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "First Name"),
                onSaved: (val) {
                  this.driverModel.setFirstName(val);
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._lastNameFocus);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Last Name",
                ),
                initialValue: this.driverModel.getLastName(),
                focusNode: this._lastNameFocus,
                onSaved: (val) {
                  this.driverModel.setLastName(val);
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._emailFocus);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                initialValue: this.driverModel.getEmail(),
                focusNode: this._emailFocus,
                onSaved: (val) {
                  this.driverModel.setEmail(val);
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(this._emailFocus);
                },
              ),
              const SizedBox(height: 10),
             
                    FlatButton(
                      color: Color(0xFF21BFBD),
                      child: Text("Pick an Image"),
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        PickedFile _image = await imagePicker.getImage(
                            source: ImageSource.gallery);
                        if (_image == null)
                          return; //add this condition so if user didn't select any image

                        File _cropped = await ImageCropper.cropImage(
                            sourcePath: _image.path,
                            
                            toolbarColor: Color(0xFF21BFBD),
                            statusBarColor: Color(0xFF21BFBD),
                            toolbarWidgetColor: Colors.white,
                            toolbarTitle: 'Crop It');
                        //If the user didn't crop image then use original image that is picked from gallery
                        if (_cropped == null) {
                          _cropped = File(_image.path);
                        }
                        image = _cropped;
                        print("cropped successfully");
                        
                        String path = 'images/${DateTime.now().toString()}.jpg';
                        _uploadTask = this
                            ._firebaseStorage
                            .ref()
                            .child(path)
                            .putFile(_cropped);
                            print("5raaaaaa");
                        _uploadTask.onComplete.then((_) async {
                          this.driverModel.setPictureUrl(await this
                              ._firebaseStorage
                              .ref()
                              .child(path)
                              .getDownloadURL());
                          setState(() {});
                          print("la2aaaa");
                        });
                        

                        setState(() {});
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          submitForm();
        },
        backgroundColor: Color(0xFF21BFBD),
      ),
    );
  }
}
