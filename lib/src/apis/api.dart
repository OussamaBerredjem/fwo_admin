import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  Api._();
  static final Api _instance = Api._();
  static Api get instance => _instance;
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }



  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserFromFirestore(String userID) async {
    try {
      return await firestore.collection('admins').doc(userID).get();
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addUserToFirestore(Map<String, dynamic> data) async {
    try {
      await firestore.collection('admins').doc(data['uId']).set(data);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> updateUser(String userID, Map<String, dynamic> data) async {
    try {
      await firestore.collection('admins').doc(userID).update(data);
    } on FirebaseException {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> ordersStream() {
    try {
      return firestore
          .collection('orders')
          .where('status', isEqualTo: 'pending')
          .orderBy('date', descending: true)
          .snapshots();
    } on FirebaseException {
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> newCompaniesStream() {
    try {
      return firestore
          .collection('users')
          .where('type', isEqualTo: 'company')
          .where('contractor', isEqualTo: false)
          .snapshots()
          .map((event) => event.docs.map((e) => e.data()).toList());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> contractCompany(String userID) async =>
      firestore.collection('users').where('uId', isEqualTo: userID).get().then(
            (value) => value.docs.first.reference.update({'contractor': true}),
          );

  Stream<List<Map<String, dynamic>>> renewalStream() {
    try {
      return firestore
          .collection('renewContract')
          .snapshots()
          .map((event) => event.docs.map((e) {
                return {
                  'id': e.id,
                  'data': e.data(),
                };
              }).toList());
    } on FirebaseException {
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> suggestionsStream() {
    try {
      return firestore
          .collection('suggestionsAndComplaints')
          .orderBy('date', descending: true)
          .snapshots()
          .map((event) => event.docs.map((e) {
                return {
                  'id': e.id,
                  'data': e.data(),
                };
              }).toList());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getUsers({
    required String userType,
    required String searchType,
    required String searchValue,
  }) async {
    try {
      return await firestore
          .collection('users')
          .where(searchType, isEqualTo: searchValue)
          .where('type', isEqualTo: userType)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    } on FirebaseException {
      rethrow;
    }
  }

  
  Future<List<Map<String, dynamic>>> getAllUsers({
    required String userType,
  }) async {
    try {
      return await firestore
          .collection('users')
          .where('type', isEqualTo: userType)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    } on FirebaseException {
      rethrow;
    }
  }


  Future<void> updateOrderStatus(String id, String status) async {
    try {
      await firestore.collection('orders').doc(id).update({'status': status});
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> deleteSuggestion(String id) async {
    try {
      await firestore.collection('suggestionsAndComplaints').doc(id).delete();
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> deleteRenewal(String id) async {
    try {
      await firestore.collection('renewContract').doc(id).delete();
    } on FirebaseException {
      rethrow;
    }
  }

  // Future<List<File>> getImages(Map<String, dynamic> company) async {
  //   try {
  //     return await FirebaseStorage.instance.ref().child(company).listAll();
  //   } on FirebaseException {
  //     rethrow;
  //   }
  // }
}
