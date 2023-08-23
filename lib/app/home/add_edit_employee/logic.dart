import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rti_employee/app/home/add_edit_employee/manager.dart';
import 'package:rti_employee/app/provider.dart';
import 'package:rti_employee/model/employee.dart';

import '../../picker.dart';

class AddEmployeeLogic {
  /// Function to add or edit employee details based on flowType
  ///
  /// * [manager] contain user entered data
  /// * [flowType] either to edit or add employee
  /// * [ref] to read EmployeeServices
  /// * [context] to display success message on failure
  ///
  static Future<void> addOrEditEmployeeToDataBase({
    required EmployeeManager manager,
    required EmployeeAddEditFlowType flowType,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final service = ref.watch(employeeServicesPr);

    final Employee employee = Employee(
      id: flowType == EmployeeAddEditFlowType.add ? '' : manager.docId,
      employeeName: manager.getName(),
      employeeRole: manager.getEmployeeRole()!,
      doj: manager.getStartDOJ(),
      dol: manager.getEndDOL(),
      isRemoved: false,
    );

    await service.addOrUpdateEmployee(
      flowType: flowType,
      employee: employee,
      onSuccess: () {
        if (flowType == EmployeeAddEditFlowType.add) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Employee Added Successfully')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Updated Successfully')));
        }
      },
      onFailure: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something Went Wrong')));
      },
    );
  }

  /// Function to add or edit employee details based on flowType
  ///
  /// * [docId] docId of the employee to be removed
  /// * [ref] to read EmployeeServices
  /// * [context] to display success message on failure
  ///
  ///
  static Future<void> removeEmployee({
    required String docId,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final service = ref.read(employeeServicesPr);
    await service.removeEmployee(
      docId: docId,
      removedTrue: true,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Employee Data has been deleted')));
      },
      onFailure: () {},
    );
  }
}
