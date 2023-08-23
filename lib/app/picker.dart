import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rti_employee/app/provider.dart';
import 'package:rti_employee/model/employee.dart';

import 'home/add_edit_employee/screen.dart';

enum EmployeeAddEditFlowType { add, edit }

/// Common screen for both add and edit so to get flowtype using picker
///
class EmployeeAddEditPicker extends ConsumerWidget {
  final EmployeeAddEditFlowType flowType;
  final Employee? employeeList;
  const EmployeeAddEditPicker({
    required this.flowType,
    this.employeeList,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(employeeManagerPr);
    manager.employeeList = employeeList;
    return AddEmployeeScreen(
      flowType: flowType,
    );
  }
}
