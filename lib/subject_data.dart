import 'package:flutter/material.dart';

class SubjectData {
  final int no;
  final String subject;
  final String status;
  final String syncStatus;
  final String sex;
  final int age;

  SubjectData(this.no, this.subject, this.status, this.syncStatus, this.sex, [this.age = -1]);

  DataRow toDataRow() => DataRow(cells: [
        DataCell(Text("$no")),
        DataCell(Text(subject)),
        DataCell(Text(status)),
        DataCell(Text(syncStatus)),
        DataCell(Text(sex)),
        DataCell(Text(age < 0 ? "-" : "$age")),
      ]);

  static List<SubjectData> sortByNo(List<SubjectData> data) {
    return data..sort((a, b) => a.no.compareTo(b.no));
  }

  static List<SubjectData> sortBySubject(List<SubjectData> data) {
    return data..sort((a, b) => int.parse(a.subject.substring(1)).compareTo(int.parse(b.subject.substring(1))));
  }

  static List<SubjectData> sortByStatus(List<SubjectData> data) {
    return data..sort((a, b) => a.status.compareTo(b.status));
  }

  static List<SubjectData> sortBySyncStatus(List<SubjectData> data) {
    return data..sort((a, b) => a.syncStatus.compareTo(b.syncStatus));
  }

  static List<SubjectData> sortBySex(List<SubjectData> data) {
    return data..sort((a, b) => a.sex.compareTo(b.sex));
  }

  static List<SubjectData> sortByAge(List<SubjectData> data) {
    return data..sort((a, b) => a.age.compareTo(b.age));
  }
}

List<SubjectData> rawData = [
  SubjectData(1, "S01001", "Screening", "Partially Done", "남"),
  SubjectData(2, "S01002", "Screening", "Partially Done", "남"),
  SubjectData(3, "S01003", "Complete", "Partially Done", "남"),
  SubjectData(4, "S01004", "Drop out", "Partially Done", "여"),
  SubjectData(5, "S01005", "Screening", "Partially Done", "남"),
  SubjectData(6, "S01006", "Screening Fail", "Partially Done", "남"),
];

const kThemeColor = Color(0xff516ceb);
const kTextPage = TextStyle(fontSize: 14);
