import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

class CsvPathsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? classname = args?['classname'] as String?;
    final String? userid = args?['userid'] as String?;
    return Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: Text('Attendance Records'),
              backgroundColor: Color.fromRGBO(169, 47, 165, 0.8),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('CSV')
                  .doc(userid)
                  .collection('csv_files')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final csvPathsDocs = snapshot.data!.docs;
                final docNames = csvPathsDocs.map((doc) => doc.id).toList();
                return ListView.builder(
                  itemCount: docNames.length,
                  itemBuilder: (context, index) {
                    final name = docNames[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(name),
                        onTap: () async {
                          final csvPathDoc = csvPathsDocs[index];
                          try {
                            final CollectionReference collectionRef =
                                FirebaseFirestore.instance
                                    .collection('CSV')
                                    .doc(userid)
                                    .collection('csv_files')
                                    .doc(name)
                                    .collection('data');
                            QuerySnapshot querySnapshot =
                                await collectionRef.get();

                            final csvList = <List<dynamic>>[];
                            final fieldNames = [
                              'Date',
                              'Name',
                              'Time of entry',
                              'Time of exit',
                              'Duration',
                              'Attendance'
                            ];
                            csvList.add(fieldNames);
                            querySnapshot.docs.forEach((doc) {
                              final rowValues = <dynamic>[];
                              fieldNames.forEach((key) {
                                final data = doc.data() as Map<String, dynamic>;
                                if (data.containsKey(key)) {
                                  final value = doc.get(key);
                                  rowValues.add(value);
                                } else {
                                  rowValues.add('');
                                }
                              });
                              csvList.add(rowValues);
                            });

                            Directory? dir;
                            dir = Directory("/storage/emulated/0/Download");

                            if (dir != null &&
                                await Permission.storage.request().isGranted) {
                              final file = File("${dir.path}/$name.csv");
                              final csvData = csvList
                                  .map((row) => row.join(','))
                                  .join('\n');
                              await file.writeAsString(csvData);
                            }
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('File saved'),
                                  content: Text('The CSV file has been saved.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } catch (e) {
                            print('Error retrieving data: $e');
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
