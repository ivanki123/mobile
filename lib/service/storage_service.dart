abstract class StorageService {
  Future<void> saveUser(String email, String password);
  Future<String?> getEmail();
  Future<String?> getPassword();
  Future<void> clearUser();
}