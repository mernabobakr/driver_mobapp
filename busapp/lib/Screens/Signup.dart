import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:busapp/models/credentials.dart';
import 'package:busapp/models/driver_signup_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

   @override
  void initState() {
    super.initState();
    this._token = Credentials.token;
    this._isLoading = true;
    driverService
        .getdriverId(this._token)
        .then(this.goToTripsIfDriverIdFound)
        .catchError(this.setIsLoadingFalse);
  }
  void setIsLoadingFalse(_) {
    setState(() {
      this._isLoading = false;
    });
  }

  void goToTripsIfDriverIdFound(http.Response response) {
    if (response.statusCode == 200) {
      var bodyMap = JsonDecoder().convert(response.body);
      Credentials.driverId = bodyMap["iddrivers"].toString();
    }
    setState(() {
      this._isLoading = false;
    });
  }

  void submitForm() async {
    print("offfffffff");
    this._formKey.currentState.save();
    print(this.driverModel.toString());
    
     

      setState(() {
         this._isLoading = true;
      });
      await uploadProfilePic();
      print(this.driverModel.getPictureUrl());
      print ("the secret token is "+this._token);
      driverService.signUp(this.driverModel,this._token).then((response) {
        print("The status code is  ");
        print(response.statusCode);
        setState(() {
           this._isLoading = false;
        });

        var bodyMap = JsonDecoder().convert(response.body);

        if (response.statusCode != 200) {
          hlp.showSimpleErrorMessage(bodyMap["message"], context);
          print("The message is " + bodyMap["message"]);
        } else {
          Credentials.driverId = bodyMap["iddrivers"];
          Credentials.firstName = bodyMap["first_name"];
          Credentials.lastName= bodyMap["last_name"];
          Credentials.email = bodyMap["email"];
          Navigator.of(context).pushReplacementNamed(TripScreen.id);
        }
      }).catchError((err) {
        hlp.showSimpleErrorMessage("Unknown Error Happened", context);
        setState(() {
          this._isLoading = false;
        });
      });
    
  }

  Future uploadProfilePic() async {
    if (image == null) return;
    String path = 'images/${DateTime.now().toString()}.jpg';
    _uploadTask = this._firebaseStorage.ref().child(path).putFile(image);
    print("5raaaaaa");
    return _uploadTask.onComplete.then((_) async {
      this.driverModel.setPictureUrl(
          await this._firebaseStorage.ref().child(path).getDownloadURL());
      setState(() {});
      print("la2aaaa");
      print("la2aaaa");
      print("la2aaaa");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
        ),
      ),
      //resizeToAvoidBottomPadding: false,
      body:
          this._isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : 
          Form(
        key: this._formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                 
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
                  validator: (value) => value.isEmpty ? 'required' : null,
                  onSaved: (val) {
                    this.driverModel.setFirstName(val);
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(this._lastNameFocus);
                  },
                ),
                const SizedBox(
                  height: 5,
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
                  validator: (value) => value.isEmpty ? 'required' : null,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(this._emailFocus);
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) => value.isEmpty
                      ? 'required'
                      : !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                          ? 'email is not valid'
                          : null,
                  initialValue: this.driverModel.getEmail(),
                  focusNode: this._emailFocus,
                  onSaved: (val) {
                    this.driverModel.setEmail(val);
                  },
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 10),

                FlatButton(
                  color: Color(0xFF21BFBD),
                  child: Text(" Upload Image"),
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    PickedFile _image =
                        await imagePicker.getImage(source: ImageSource.gallery);
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

                    print("cropped successfully");
                    setState(() {
                      image = _cropped;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: submitForm,
        backgroundColor: Color(0xFF21BFBD),
      ),
    );
  }
}
