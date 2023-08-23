import 'package:rti_employee/model/employee.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeManager {
  Employee? employeeList;
  String docId = '';

  //----------------------------- Name subject declaration --------------------

  final BehaviorSubject<String> employeeName =
      BehaviorSubject<String>.seeded('');

  final BehaviorSubject<String?> employeeRole =
      BehaviorSubject<String>.seeded('Select Role');

  final BehaviorSubject<DateTime> _startDateController =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  final BehaviorSubject<DateTime> _endDateController =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  //---------------------------- Set method -------------------------

  void setEmployeeName(String value) => employeeName.sink.add(value);

  void setEmployeeRole(String value) => employeeRole.sink.add(value);

  void setStartDOJ(DateTime value) {
    _startDateController.sink.add(value);
  }

  void setStartDOL(DateTime value) {
    _endDateController.sink.add(value);
  }

  //--------------------------- Get method --------------------------
  String getName() => employeeName.value;

  String? getEmployeeRole() => employeeRole.value;

  DateTime getStartDOJ() {
    return _startDateController.value;
  }

  DateTime getEndDOL() {
    return _endDateController.value;
  }

  //------------ subject dispose ------------

  void dispose() {
    employeeName.close();
    employeeRole.close();
    _startDateController.close();
    _endDateController.close();
  }
}
