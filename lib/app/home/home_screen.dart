import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/colors.dart';
import '../picker.dart';
import '../provider.dart';
import 'add_edit_employee/widgets/preview_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: _buildEmployee(context),
      floatingActionButton: buildFab(context),
    );
  }

  Widget _buildEmployee(BuildContext context) {
    ref.watch(employeeServicesPr);
    final employee$ = ref.watch(employeeList$);
    return employee$.when(
      /// the stream provider gives the employee list
      data: (employeeList) {
        // if employee list has data then send to preview list
        //
        if (employeeList.isNotEmpty) {
          return EmployeePreviewListWidget(employeeList: employeeList);
        } else {
          // if employee list empty display image
          //
          return buildNoData();
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget buildNoData() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Center(
        child: Image.asset(noImage),
      ),
    );
  }

  Widget buildFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmployeeAddEditPicker(
              flowType: EmployeeAddEditFlowType.add,
            ),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
