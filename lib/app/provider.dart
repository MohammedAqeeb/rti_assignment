import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rti_employee/app/home/add_edit_employee/manager.dart';
import 'package:rti_employee/services/employee.dart';

/// Provider to expose EmployeeManager instance
///
///
final employeeManagerPr = Provider.autoDispose((ref) {
  final manager = EmployeeManager();
  ref.onDispose(() {
    manager.dispose();
  });
  return manager;
});

/// Provider to mainatain state of EmployeeServices 
///
final employeeServicesPr = Provider.autoDispose((ref) {
  final service = EmployeeServices();
  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

/// StreamProvider to maintain state of employeeList
///
final employeeList$ = StreamProvider.autoDispose((ref) {
  final service = ref.watch(employeeServicesPr);
  service.getEmployeed();
  return service.employeeSubject.stream;
});
