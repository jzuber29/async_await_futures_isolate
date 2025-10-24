import 'dart:isolate';

class HeavyTask {
  static Future<String> runInIsolate() async {
    final receivePort = ReceivePort();

    // Spawn an isolate
    await Isolate.spawn(_heavyComputation, receivePort.sendPort);

    // Wait for the isolate to send data
    final message = await receivePort.first;
    return message;
  }

  // Runs in another isolate
  static void _heavyComputation(SendPort sendPort) {
    int sum = 0;
    for (int i = 0; i < 300000000; i++) {
      sum += i;
    }
    sendPort.send("🧠 Heavy Computation Done! Sum = $sum");
  }
}
