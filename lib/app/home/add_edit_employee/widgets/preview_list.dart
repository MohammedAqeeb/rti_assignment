import 'package:flutter/widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../../../model/employee.dart';
import 'header.dart';
import 'preview.dart';

class EmployeePreviewListWidget extends StatelessWidget {
  final List<Employee> employeeList;
  const EmployeePreviewListWidget({
    required this.employeeList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // checking the value wheater employee is removed or not
    List<Employee> activeEmployees =
        employeeList.where((employee) => !employee.isRemoved).toList();
    List<Employee> removedEmployees =
        employeeList.where((employee) => employee.isRemoved).toList();
    return CustomScrollView(
      slivers: [
        //  employee is not removed then showing sticky head curent employee
        SliverStickyHeader(
          header: const Header(title: 'Current Employees'),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var current = activeEmployees[index];
                return EmployeePreviewWidget(
                  employee: current,
                );
              },
              childCount: activeEmployees.length,
            ),
          ),
        ),
        //  employee is not removed then showing sticky head Previous employee
        if (removedEmployees.isNotEmpty)
          SliverStickyHeader(
            header: const Header(title: 'Previous Employees'),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var removed = removedEmployees[index];
                  return EmployeePreviewWidget(
                    employee: removed,
                  );
                },
                childCount: removedEmployees.length,
              ),
            ),
          ),
      ],
    );
  }
}
