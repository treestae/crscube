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
  int _tableIndex = 0;
  final List<bool> _isAscending = [false, false, false, false, false, false];
  List<SubjectData> _samples = rawData.toList();

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
                  "+${_samples.length}",
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
            headingRowHeight: 40,
            dataRowHeight: 40,
            headingRowColor: MaterialStateProperty.resolveWith<Color?>((states) => Colors.grey[300]),
            columns: [
              DataColumn(
                label: SizedBox(
                    width: width * 0.1,
                    child: Row(
                      children: [
                        const Text("No."),
                        _getSortingIcon(0),
                      ],
                    )),
                onSort: (index, _) {
                  _samples = _getSortedSamples(index, SubjectData.sortByNo);
                  setState(() {});
                },
              ),
              DataColumn(
                label: SizedBox(
                    width: width * 0.1,
                    child: Row(
                      children: [
                        const Text("Subject."),
                        _getSortingIcon(1),
                      ],
                    )),
                onSort: (index, _) {
                  _samples = _getSortedSamples(index, SubjectData.sortBySubject);
                  setState(() {});
                },
              ),
              DataColumn(
                label: SizedBox(
                    width: width * 0.2,
                    child: Row(
                      children: [
                        const Text("상태."),
                        _getSortingIcon(2),
                      ],
                    )),
                onSort: (index, _) {
                  _samples = _getSortedSamples(index, SubjectData.sortByStatus);
                  setState(() {});
                },
              ),
              DataColumn(
                label: SizedBox(
                    width: width * 0.2,
                    child: Row(
                      children: [
                        const Text("Sync Status."),
                        _getSortingIcon(3),
                      ],
                    )),
                onSort: (index, _) {
                  _samples = _getSortedSamples(index, SubjectData.sortBySyncStatus);
                  setState(() {});
                },
              ),
              DataColumn(
                label: SizedBox(
                    width: width * 0.1,
                    child: Row(
                      children: [
                        const Text("Sex."),
                        _getSortingIcon(4),
                      ],
                    )),
                onSort: (index, _) {
                  _samples = _getSortedSamples(index, SubjectData.sortBySex);
                  setState(() {});
                },
              ),
              DataColumn(
                label: SizedBox(
                    width: width * 0.1,
                    child: Row(
                      children: [
                        const Text("Age."),
                        _getSortingIcon(5),
                      ],
                    )),
                onSort: (index, _) {
                  _samples = _getSortedSamples(index, SubjectData.sortByAge);
                  setState(() {});
                },
              ),
            ],
            rows: _samples.map((s) => s.toDataRow()).toList(),
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

  /// 정렬 아이콘 위젯을 리턴한다.
  Widget _getSortingIcon(int index) {
    return _tableIndex == index
        ? _isAscending[_tableIndex]
            ? const Icon(Icons.arrow_downward)
            : const Icon(Icons.arrow_upward)
        : const SizedBox();
  }

  /// 원본 데이터를 2번째 파라미터로 넘겨준 정렬함수로 정렬하여 리턴한다.
  List<SubjectData> _getSortedSamples(int index, List<SubjectData> Function(List<SubjectData>) sortFunction) {
    _tableIndex = index;
    _isAscending[index] = !_isAscending[index];
    return _isAscending[index] ? sortFunction(rawData).reversed.toList() : sortFunction(rawData);
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
