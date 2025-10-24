import 'package:flutter/material.dart';
import 'services/async_service.dart';
import 'services/heavy_task.dart';
import 'widgets/result_card.dart';

void main() {
  runApp(const AsyncApp());
}

class AsyncApp extends StatefulWidget {
  const AsyncApp({super.key});

  @override
  State<AsyncApp> createState() => _AsyncAppState();
}

class _AsyncAppState extends State<AsyncApp> {
  String result = "No result yet";
  bool isLoading = false;

  void _runAsyncTask() async {
    setState(() => isLoading = true);
    result = await AsyncService.fetchData();
    setState(() => isLoading = false);
  }

  void _runIsolateTask() async {
    setState(() => isLoading = true);
    result = await HeavyTask.runInIsolate();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Async & Isolate Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Async / Await / Isolate Demo')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResultCard(result: result),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : _runAsyncTask,
                  child: const Text("Run Async Task"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: isLoading ? null : _runIsolateTask,
                  child: const Text("Run Isolate Task"),
                ),
                const SizedBox(height: 20),
                if (isLoading) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
