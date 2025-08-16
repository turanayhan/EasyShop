
import 'package:case1/core/network/api_endpoints.dart';


import 'dio_client.dart';


class ApiService {
  final DioClient _dioClient = DioClient(baseUrl: ApiEndpoints.baseUrl);

  // Post listesini çek
  Future<List<dynamic>> fetchPosts() async {
    final response = await _dioClient.dio.get(ApiEndpoints.posts);
    return response.data;
  }

  // Kullanıcı listesini çek
  Future<List<dynamic>> fetchUsers() async {
    final response = await _dioClient.dio.get(ApiEndpoints.users);
    return response.data;
  }
}

