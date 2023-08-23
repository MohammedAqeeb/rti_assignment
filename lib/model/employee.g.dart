// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['id'] as String,
      employeeName: json['employeeName'] as String,
      employeeRole: json['employeeRole'] as String,
      doj: DateTime.parse(json['doj'] as String),
      dol: DateTime.parse(json['dol'] as String),
      isRemoved: json['isRemoved'] as bool,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'employeeRole': instance.employeeRole,
      'doj': instance.doj.toIso8601String(),
      'dol': instance.dol.toIso8601String(),
      'isRemoved': instance.isRemoved,
    };
