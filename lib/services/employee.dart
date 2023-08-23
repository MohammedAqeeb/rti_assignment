import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rti_employee/model/employee.dart';
import 'package:rxdart/rxdart.dart';

import '../app/picker.dart';

class EmployeeServices {
  static final db = FirebaseFirestore.instance;

  final BehaviorSubject<List<Employee>> employeeSubject =
      BehaviorSubject<List<Employee>>();

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  /// Function to add or edit employee details based on flowType
  ///
  /// * [flowType] either to edit or add employee
  /// * [employee] employee json model to store in firebase
  /// * [onSuccess] to display success message on screenn
  /// * [onFailure] to display success message on failure
  ///
  Future<void> addOrUpdateEmployee({
    required EmployeeAddEditFlowType flowType,
    required Employee employee,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    // if the flowtype is of add then value is added on firebase
    if (flowType == EmployeeAddEditFlowType.add) {
      final ref = db.collection('employee').doc();

      employee.id = ref.id;

      await ref.set(employee.toJson()).then((value) {
        onSuccess();
      }).onError((error, stackTrace) {
        onFailure();
      });
      // if the flowtype is of edit then value is updated
    } else if (flowType == EmployeeAddEditFlowType.edit) {
      final ref = db.collection('employee').doc(employee.id);

      await ref.update(employee.toJson()).then((value) {
        onSuccess();
      }).onError((error, stackTrace) {
        onFailure();
      });
    }
  }

  /// Function to get all the employees
  ///
  ///
  void getEmployeed() {
    List<Employee> employeeList = [];

    streamSubscription = db
        .collection('employee')
        .orderBy('doj', descending: true)
        .snapshots()
        .listen(
      (value) {
        employeeList.clear();
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            employeeList.add(Employee.fromJson(doc.data()));
            employeeSubject.sink.add(employeeList);
          }
        } else {
          employeeSubject.sink.add(employeeList);
        }
      },
    );
  }

  /// Function to remove the current employee
  ///
  /// * [docId] docId of the employee to be removed
  /// * [removedTrue] boolean value true indicated employee removed
  /// * [onSuccess] to display success message on screenn
  /// * [onFailure] to display success message on failure
  ///
  Future<void> removeEmployee({
    required String docId,
    required bool removedTrue,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    final ref = db.collection('employee').doc(docId);

    await ref
        .update(
          {'isRemoved': removedTrue},
        )
        .then((value) => onSuccess())
        .onError(
          (error, stackTrace) => onFailure,
        );
  }

  void dispose() {
    employeeSubject.close();
    streamSubscription?.cancel();
  }
}
