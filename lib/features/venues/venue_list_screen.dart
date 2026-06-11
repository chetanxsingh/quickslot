import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../slots/slot_screen.dart';
import '../bookings/bookings_screen.dart';
import '../../widgets/loading.dart';

class VenueListScreen extends StatefulWidget {
  @override
  State<VenueListScreen> createState() => _VenueListScreenState();
}

class _VenueListScreenState extends State<VenueListScreen> {
  List venues = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    final res = await ApiClient().dio.get("/venues/");
    venues = res.data;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickSlot"),
        actions: [
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BookingsScreen()),
            ),
          )
        ],
      ),
      body: loading
          ? LoadingWidget()
          : ListView.builder(
              itemCount: venues.length,
              itemBuilder: (_, i) {
                final v = venues[i];
                return Card(
                  child: ListTile(
                    title: Text(v['name']),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SlotScreen(venueId: v['id']),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
