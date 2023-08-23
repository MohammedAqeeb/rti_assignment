import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rti_employee/app/home/add_edit_employee/logic.dart';
import 'package:rti_employee/constants/style.dart';
import 'package:rti_employee/model/employee.dart';

import '../../../picker.dart';

class EmployeePreviewWidget extends ConsumerWidget {
  final Employee employee;
  const EmployeePreviewWidget({
    required this.employee,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(employee.id),
      background: !employee.isRemoved
          ? Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 22.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 32,
              ),
            )
          : const SizedBox(),
      onDismissed: (direction) {
        if (employee.isRemoved == false) {
          AddEmployeeLogic.removeEmployee(
            docId: employee.id,
            ref: ref,
            context: context,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something Went Wrong')));
        }
      },
      child: buildCard(context),
    );
  }

  Widget buildCard(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeAddEditPicker(
                flowType: EmployeeAddEditFlowType.edit,
                employeeList: employee,
              ),
            ),
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.all(22),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.employeeName,
                style: employeeNameStyle,
              ),
              const SizedBox(height: 6),
              Text(
                employee.employeeRole,
                style: subHeadingStlye,
              ),
              const SizedBox(height: 6),
              !employee.isRemoved
                  ? Text(
                      'From ${DateFormat('dd MMM yyyy').format(employee.doj)}',
                      style: subHeading2,
                    )
                  : Text(
                      '${DateFormat('dd MMM yyyy').format(employee.doj)} - ${DateFormat('dd MMM yyyy').format(employee.dol)}',
                      style: subHeading2,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
