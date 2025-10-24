import 'dart:async';

class AsyncService {
  static Future<String> fetchData() async {
    // Simulate a delayed API or DB call
    await Future.delayed(const Duration(seconds: 2));
    return "✅ Async Task Completed (fetched after 2 seconds)";
  }
}
