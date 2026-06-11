import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../../widgets/loading.dart';

class SlotScreen extends StatefulWidget {
  final int venueId;
  SlotScreen({required this.venueId});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  List slots = [];
  bool loading = true;
  DateTime selectedDate = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetch();
    timer = Timer.periodic(Duration(seconds: 5), (_) => fetch());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  fetch() async {
    final res = await ApiClient().dio.get(
      "/venues/${widget.venueId}/slots",
      queryParameters: {"date": selectedDate.toString().split(' ')[0]},
    );
    slots = res.data;
    setState(() => loading = false);
  }

  pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    if (date != null) {
      selectedDate = date;
      fetch();
    }
  }

  book(int id) async {
    try {
      await ApiClient().dio.post("/bookings/", data: {"slot_id": id});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booked")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Already booked")),
      );
    }
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slots"),
        actions: [
          IconButton(icon: Icon(Icons.calendar_today), onPressed: pickDate)
        ],
      ),
      body: loading
          ? LoadingWidget()
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: slots.length,
              itemBuilder: (_, i) {
                final s = slots[i];
                final booked = s['is_booked'];

                return GestureDetector(
                  onTap: booked ? null : () => book(s['id']),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: booked ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        s['time'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
