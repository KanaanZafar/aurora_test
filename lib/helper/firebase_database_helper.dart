import 'package:aurora_test/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

writeUserInformation({UserModel userModel}) async {
  try {
    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    await dbRef.child(userModel.user.uid).set(userModel.toMap());
  } catch (e) {
    print("-----error in db: ${e.toString()}");
  }
}

Future<Map> fetchUserInformation(String userId) async {
  Map data;
  try {
    DatabaseReference dbRef = FirebaseDatabase.instance.reference();

    DataSnapshot dataSnapshot = await dbRef.child(userId).once();
    if (dataSnapshot != null && dataSnapshot.value != null) {
      data = dataSnapshot.value;
    }
  } catch (e) {
    print("----error: ${e.toString()}");
  }
  return data;
}
