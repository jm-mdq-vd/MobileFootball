abstract class Repository<Resource> {
  Future<List<Resource>> getResource(Map<String, dynamic>? parameters);
}