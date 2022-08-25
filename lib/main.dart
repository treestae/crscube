import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_radio_tile.dart';
import 'subject_data.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: (() {})),
        title: const Text("Subject"),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
        elevation: 0,
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _radioValue = 1;
  int _tableSortIndex = 1;
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Column(
        children: [
          AppBar(
            leading: const Icon(CupertinoIcons.doc_checkmark),
            title: const Text("DDC_SAMPLE_STUDY_01"),
            backgroundColor: kThemeColor,
          ),
          AppBar(
            leading: const SizedBox(width: 10),
            leadingWidth: 10,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                const Text(
                  "List view   ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "+${samples.length}",
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
            actions: [
              CustomRadioTile<int>(
                value: 1,
                groupValue: _radioValue,
                leading: Icons.menu,
                onChanged: (value) => setState(() => _radioValue = value!),
              ),
              CustomRadioTile<int>(
                value: 2,
                groupValue: _radioValue,
                leading: Icons.abc,
                onChanged: (value) => setState(() => _radioValue = value!),
              ),
              const SizedBox(width: 30),
            ],
          ),
          DataTable(
            columnSpacing: 0,
            columns: [
              DataColumn(
                label: SizedBox(width: width * 0.1, child: const Text("No.")),
                onSort: (columnIndex, ascending) {
                  if (_tableSortIndex != columnIndex) {
                    _tableSortIndex = 0;
                    _isAscending = false;
                  } else {
                    _isAscending = !_isAscending;
                  }

                  samples = _isAscending ? SubjectData.sortByNo(samples) : SubjectData.sortByNo(samples).reversed.toList();
                  setState(() {});

                  print(samples[0].no);
                },
              ),
              DataColumn(
                label: SizedBox(width: width * 0.2, child: const Text("Subject.")),
                onSort: (columnIndex, ascending) {
                  if (_tableSortIndex != columnIndex) {
                    _tableSortIndex = 1;
                    _isAscending = false;
                  } else {
                    _isAscending = !_isAscending;
                  }

                  samples = _isAscending ? SubjectData.sortBySubject(samples) : SubjectData.sortBySubject(samples).reversed.toList();
                  setState(() {});
                },
              ),
              DataColumn(label: SizedBox(width: width * 0.2, child: const Text("상태."))),
              DataColumn(label: SizedBox(width: width * 0.2, child: const Text("Sync Status."))),
              DataColumn(label: SizedBox(width: width * 0.15, child: const Text("Sex."))),
              DataColumn(label: SizedBox(width: width * 0.15, child: const Text("Age."))),
            ],
            rows: samples.map((s) => s.toDataRow()).toList(),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Pagenation(),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class Pagenation extends StatelessWidget {
  const Pagenation({Key? key}) : super(key: key);
  final int pageNum = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios, color: Colors.grey)),
        Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pageNum.toString().padLeft(2, '0'), style: kTextPage.copyWith(color: Colors.blue)),
              const Text("/", style: kTextPage),
              const Text("01", style: kTextPage),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey)),
      ],
    );
  }
}

const kTextPage = TextStyle(fontSize: 14);
