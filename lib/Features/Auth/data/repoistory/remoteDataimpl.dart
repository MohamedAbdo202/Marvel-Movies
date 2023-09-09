import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/AuthRepository.dart';
import '../datasources/localDataSources.dart';
import '../datasources/remoteDataFirebase.dart';
import '../models/usermodel.dart';

class RemoteRepoistoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthRemote authRemote;
  final AuthLocalDataSource authLocalDataSource;

  RemoteRepoistoryImpl({required this.authRemote, required this.authLocalDataSource});

  @override
  Future<User?> registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      // Use the provided AuthRemote to register the user
      final UserModel? userModel = await authRemote.registerWithEmailAndPassword(name, email, password);

      if (userModel != null) {
        // Cache the user's ID
        await authLocalDataSource.cacheUserId(userModel.id);

        // Return the authenticated user (Firebase User)
        return _firebaseAuth.currentUser;
      } else {
        return null; // Registration failed
      }
    } catch (e) {
      print("Error registering: $e");
      return null; // Handle registration error
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Use the provided AuthRemote to sign in the user
      final UserModel? userModel = await authRemote.signInWithEmailAndPassword(email, password);

      if (userModel != null) {
        // Cache the user's ID
        await authLocalDataSource.cacheUserId(userModel.id);

        // Return the authenticated user (Firebase User)
        return _firebaseAuth.currentUser;
      } else {
        return null; // Sign-in failed
      }
    } catch (e) {
      print("Error signing in: $e");
      return null; // Handle sign-in error
    }
  }
}
