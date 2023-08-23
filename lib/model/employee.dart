import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  String id;
  final String employeeName, employeeRole;

  final DateTime doj, dol;

  final bool isRemoved;

  Employee({
    required this.id,
    required this.employeeName,
    required this.employeeRole,
    required this.doj,
    required this.dol,
    required this.isRemoved,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
