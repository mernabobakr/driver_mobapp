class DriverSignupModel {
  String _firstName;
  String _lastName;
  String _email;
  String pictureUrl;

  DriverSignupModel.build(this._firstName, this._lastName, this._email);

  DriverSignupModel();

  @override
  String toString() {
    return 'DriverSignupModel{_firstName: $_firstName, _lastName: $_lastName, _email: $_email, pictureUrl: $pictureUrl}';
  }

  Map<String, dynamic> get toJson => {
        "first_name": _firstName,
        "last_name": _lastName,
        "email": _email,
        "picture_url": pictureUrl,
      };

  void setFirstName(String firstName) {
    this._firstName = firstName;
  }

  void setLastName(String lastName) {
    this._lastName = lastName;
  }

  void setEmail(String email) {
    this._email = email;
  }

  void setPictureUrl(String pictureUrl) {
    this.pictureUrl = pictureUrl;
  }

  String getFirstName() {
    return this._firstName;
  }

  String getLastName() {
    return this._lastName;
  }

  String getEmail() {
    return this._email;
  }

  String getPictureUrl() {
    return this.pictureUrl;
  }
}
