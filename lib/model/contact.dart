
final String COL_NAME = "name";
final String COL_EMAIL = "email";
class Contact{
  String name,email;
  Contact({this.name,this.email});

  Contact.map(dynamic obj1){
      this.name = obj1['NAME'];
      this.email = obj1['EMAIL'];

  }


  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{//method
      COL_NAME : name,
      COL_EMAIL: email,

    };
      return map;
  }
  Contact.fromMap(Map<String,dynamic> map){//named constructor to return emoloyee model obj

    name = map[COL_NAME];
    email = map[COL_EMAIL];
  }

  @override
  String toString() {
    return 'Contact{name: $name, email: $email}';
  }

}