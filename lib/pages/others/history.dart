import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langconnect/utilities/history_service.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const HistoryItems();
  }
}

class HistoryItems extends StatefulWidget {
  const HistoryItems({super.key});

  @override
  State<HistoryItems> createState() => _HistoryItemsState();
}

class _HistoryItemsState extends State<HistoryItems> {
  late Future<List<Map<String, String>>> future;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    future = HistoryService().getHistory(email);
  }

  void _reloadHistory() {
    setState(() {
      _loadHistory(); // Reload the history
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading history"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No history found"));
        } else {
          List<Map<String, String>> history = snapshot.data!;
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              Map<String, String> historyItem = history[index];
              return ListTile(
                title: Text(historyItem["originalText"] ?? "No original text"),
                subtitle:
                    Text(historyItem["translatedText"] ?? "No translated text"),
                trailing: DeleteBtn(
                  index: index,
                  onDelete: _reloadHistory, // Pass the reload callback
                ),
              );
            },
          );
        }
      },
    );
  }
}

class DeleteBtn extends StatelessWidget {
  final int index;
  final VoidCallback onDelete;

  const DeleteBtn({
    super.key,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        await HistoryService().removeFromHistory(
          FirebaseAuth.instance.currentUser!.email!,
          index,
        );
        onDelete(); // Trigger the reload callback
      },
    );
  }
}
