import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  // Upload image and return download URL
  Future<String> uploadImage({
    required File file,
    required String folder,
    String? fileName,
  }) async {
    try {
      final String name = fileName ?? '${_uuid.v4()}.jpg';
      final Reference ref = _storage.ref().child('$folder/$name');
      
      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  // Upload multiple images
  Future<List<String>> uploadImages({
    required List<File> files,
    required String folder,
  }) async {
    try {
      final List<String> urls = [];
      
      for (final file in files) {
        final url = await uploadImage(file: file, folder: folder);
        urls.add(url);
      }
      
      return urls;
    } catch (e) {
      rethrow;
    }
  }

  // Delete image by URL
  Future<void> deleteImage(String imageUrl) async {
    try {
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      rethrow;
    }
  }

  // Delete multiple images
  Future<void> deleteImages(List<String> imageUrls) async {
    try {
      await Future.wait(
        imageUrls.map((url) => deleteImage(url)),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get download URL from path
  Future<String> getDownloadURL(String path) async {
    try {
      final Reference ref = _storage.ref().child(path);
      return await ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
