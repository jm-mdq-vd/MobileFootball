import 'endpoint.dart';
import '../models/models.dart';

abstract class ApiClient {
  Future<APIResponse> getResponseFromEndpoint<T>(Endpoint endpoint, Map<String, dynamic>? parameters,);
}