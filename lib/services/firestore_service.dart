import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Users Collection
  CollectionReference get usersCollection => _db.collection('users');
  
  // Products Collection
  CollectionReference get productsCollection => _db.collection('products');
  
  // Orders Collection
  CollectionReference get ordersCollection => _db.collection('orders');
  
  // Transactions Collection
  CollectionReference get transactionsCollection => _db.collection('transactions');
  
  // Sell Requests Collection
  CollectionReference get sellRequestsCollection => _db.collection('sell_requests');
  
  // Campaigns Collection
  CollectionReference get campaignsCollection => _db.collection('campaigns');

  // Generic CRUD operations
  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    try {
      await _db.collection(collection).doc(docId).set(data, SetOptions(merge: merge));
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      return await _db.collection(collection).doc(docId).get();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collection).doc(docId).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      await _db.collection(collection).doc(docId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<DocumentSnapshot> documentStream({
    required String collection,
    required String docId,
  }) {
    return _db.collection(collection).doc(docId).snapshots();
  }

  Stream<QuerySnapshot> collectionStream({
    required String collection,
    Query Function(Query)? queryBuilder,
  }) {
    Query query = _db.collection(collection);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query.snapshots();
  }

  Future<QuerySnapshot> queryCollection({
    required String collection,
    Query Function(Query)? queryBuilder,
  }) async {
    try {
      Query query = _db.collection(collection);
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      return await query.get();
    } catch (e) {
      rethrow;
    }
  }
}
