import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../../widgets/loading.dart';

class BookingsScreen extends StatefulWidget {
  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  List bookings = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    final res = await ApiClient().dio.get("/users/1/bookings");
    bookings = res.data;
    setState(() => loading = false);
  }

  cancel(int id) async {
    await ApiClient().dio.delete("/bookings/$id");
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bookings")),
      body: loading
          ? LoadingWidget()
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (_, i) {
                final b = bookings[i];
                return ListTile(
                  title: Text("Slot ${b['slot_time']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => cancel(b['id']),
                  ),
                );
              }),
    );
  }
}
