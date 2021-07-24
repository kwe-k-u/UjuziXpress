

class Rider{
  String? _name;
  String? _phoneNumber;
  String? _profileImageUrl;

  String get name => this._name ?? "";
  String get phoneNumber => this._phoneNumber ?? "";
  String get imageUrl => this._profileImageUrl ?? "";

  Rider(this._name, this._phoneNumber, this._profileImageUrl);
}