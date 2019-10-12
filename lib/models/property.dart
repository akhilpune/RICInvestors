import 'package:firebase_database/firebase_database.dart';

class Property {

  String _id;
  String _propId;
  String _pname;
  String _description;
  String _avatarUrl;
  String _location;
  String _yeild;
  String _mvalue;
  String _IRR;
  String _isCompleted;
  String _pictures1;
  String _pictures2;
  String _pictures3;
  String _pictures4;
  String _pictures5;
  String _pattributes1;
  String _pattributes2;
  String _pattributes3;
  String _pattributes4;
  String _pattributes5;

  Property(this._id,
      this._propId,
      this._pname,
      this._description,
      this._avatarUrl,
      this._location,
      this._yeild,
      this._mvalue,
      this._IRR,
      this._isCompleted,
      this._pictures1,
      this._pictures2,
      this._pictures3,
      this._pictures4,
      this._pictures5,
      this._pattributes1,
      this._pattributes2,
      this._pattributes3,
      this._pattributes4,
      this._pattributes5,
      );

  String get propId => _propId;

  String get pname => _pname;

  String get description => _description;

  String get avatarUrl => _avatarUrl;

  String get location => _location;

  String get yeild => _yeild;

  String get mvalue => _mvalue;

  String get IRR => _IRR;

  String get isCompleted => _isCompleted;

  String get pictures1 => _pictures1;
  String get pictures2 => _pictures2;
  String get pictures3 => _pictures3;
  String get pictures4 => _pictures4;
  String get pictures5 => _pictures5;

  String get pattributes1 => _pattributes1;
  String get pattributes2 => _pattributes2;
  String get pattributes3 => _pattributes3;
  String get pattributes4 => _pattributes4;
  String get pattributes5 => _pattributes5;

  String get id => _id;

  Property.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    // _name = snapshot.value['name'];
    // _email = snapshot.value['email'];
    // _age = snapshot.value['age'];
    // _mobile = snapshot.value['mobile'];

    _propId= snapshot.value['id'];
    _pname= snapshot.value['pname'];
    _description= snapshot.value['description'];
    _avatarUrl= snapshot.value['avatarUrl'];
    _location= snapshot.value['location'];
    _yeild= snapshot.value['yeild'];
    _mvalue= snapshot.value['mvalue'];
    _IRR= snapshot.value['IRR'];
    _isCompleted= snapshot.value['isCompleted'];
    _pictures1= snapshot.value['pictures1'];
    _pictures2= snapshot.value['pictures2'];
    _pictures3= snapshot.value['pictures3'];
    _pictures4= snapshot.value['pictures4'];
    _pictures5= snapshot.value['pictures5'];
    _pattributes1= snapshot.value['pattributes1'];
    _pattributes2= snapshot.value['pattributes2'];
    _pattributes3= snapshot.value['pattributes3'];
    _pattributes4= snapshot.value['pattributes4'];
    _pattributes5= snapshot.value['pattributes5'];
  }

}
