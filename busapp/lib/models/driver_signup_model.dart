class DriverSignupModel {
  String _firstName;
  String _lastName;
  String _email;
  String pictureUrl;

  DriverSignupModel.build(this._firstName, this._lastName, this._email);
  DriverSignupModel();

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
