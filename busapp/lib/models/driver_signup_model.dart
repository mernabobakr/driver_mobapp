class DriverSignupModel {
  String _firstName;
  String _lastName;
  String _email;
  String pictureUrl;
  int driverId;

  DriverSignupModel.build(this.driverId, this._firstName, this._lastName,
      this._email, this.pictureUrl);

  DriverSignupModel();

  factory DriverSignupModel.fromJson(Map json) => DriverSignupModel.build(
        json['id'],
        json['first_name'],
        json['last_name'],
        json['email'],
        json['picUrl'],
      );

  @override
  String toString() {
    return 'DriverSignupModel{_firstName: $_firstName, _lastName: $_lastName, _email: $_email, pictureUrl: $pictureUrl}';
  }

  Map<String, dynamic> get toJson => {
        "first_name": _firstName,
        "last_name": _lastName,
        "email": _email,
        "picUrl": pictureUrl,
      };

  Map<String, dynamic> get userData => Map.from(toJson)..['id'] = this.driverId;

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
