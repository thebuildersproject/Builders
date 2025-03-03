import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buildingapp/Parking_Pages/parking_count.dart';

class RedParkingPage  extends StatefulWidget {
  const RedParkingPage({super.key});

  @override
  State<RedParkingPage> createState() => _RedParkingPageState();
}

class _RedParkingPageState extends State<RedParkingPage> {
  String _selectedSection = 'Colosseum';
  final List<String> sections = ['Colosseum', 'Corely'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Red Parking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              const Icon(Icons.badge_outlined, size: 28),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton<String>(
            value: _selectedSection,
            onChanged: (value) {
              setState(() {
                _selectedSection = value!;
              });
            },
            isExpanded: true,
            items: sections.map((section) {
              return DropdownMenuItem(
                value: section,
                child: Text(
                  section,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('plates')
                .where('tagColor', isEqualTo: 'red')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No red-tagged plates found.'));
              }
              final plateDocs = snapshot.data!.docs; // Instead of first, use the list
              return StreamBuilder<QuerySnapshot>(
                stream: plateDocs.isNotEmpty
                    ? plateDocs.first.reference.collection(_selectedSection).snapshots()
                    : null,
                builder: (context, lotSnapshot) {
                  if (lotSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!lotSnapshot.hasData || lotSnapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No parking lots available.'));
                  }
                  final lots = lotSnapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: lots.length,
                    itemBuilder: (context, index) {
                      final lot = lots[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(
                            lot['lotName'] ?? 'Unknown Lot',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: lot['description'] != null
                              ? Text(lot['description'])
                              : null,
                          trailing: Text(
                            "${lot['openSpots'] ?? 0}/${lot['maxSpots'] ?? 0} open",
                            style: TextStyle(
                              color: (lot['openSpots'] ?? 0) == 0 ? Colors.red : Colors.green,
                            ),
                          ),
                          onTap: () {
                            _showNavigateDialog(
                              context,
                              lot['lotName'] ?? 'Unknown Lot',
                              lot['maxSpots'] ?? 0,
                              lot['openSpots'] ?? 0,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showNavigateDialog(
      BuildContext context,
      String parkingLotName,
      int maxSpots,
      int openSpots,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, size: 24),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Navigate to $parkingLotName?',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParkingCountPage(
                        parkingLotName: parkingLotName,
                        maxSpots: maxSpots,
                        openSpots: openSpots,
                      ),
                    ),
                  );
                },
                child: const Text('View Lot?'),
              ),
            ],
          ),
        );
      },
    );
  }
}
