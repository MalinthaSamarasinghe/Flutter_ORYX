class ApiEndpoints {
  /// Local Server
  static const baseURL = "http://10.0.2.2:8000/api";
  static const baseImageUrl = "";

  /// Live Server
  // static const baseURL = "";
  // static const baseImageUrl = "";

  /// API Endpoints
  /// User Module
  static String login = "$baseURL/login";
  static String register = "$baseURL/register";

  /// Product Module
  static String products = "$baseURL/products";
}
