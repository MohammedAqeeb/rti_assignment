import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rti_employee/app/home/add_edit_employee/manager.dart';
import 'package:rti_employee/app/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/style.dart';
import 'logic.dart';
import '../../picker.dart';

class AddEmployeeScreen extends ConsumerStatefulWidget {
  final EmployeeAddEditFlowType flowType;
  const AddEmployeeScreen({
    required this.flowType,
    super.key,
  });

  @override
  AddEmployeeScreenState createState() => AddEmployeeScreenState();
}

class AddEmployeeScreenState extends ConsumerState<AddEmployeeScreen> {
  late EmployeeManager manager;

  double bottomSheetHeight = 216.0;
  int value = 0;

  String startDate = 'Today';
  String endDate = 'No Date';

  final items = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];

  @override
  void initState() {
    manager = ref.read(employeeManagerPr);
    if (widget.flowType == EmployeeAddEditFlowType.edit &&
        manager.employeeList != null) {
      manager.docId = manager.employeeList!.id;

      manager.setEmployeeName(manager.employeeList!.employeeName);
      manager.setStartDOJ(manager.employeeList!.doj);
      manager.setEmployeeRole(manager.employeeList!.employeeRole);
      manager.setStartDOL(manager.employeeList!.dol);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.flowType == EmployeeAddEditFlowType.add
              ? 'Add Employee Details'
              : 'Edit Employee Details',
          style: appBarTextStyle,
        ),
      ),
      body: buildBody(context),
      floatingActionButton: buildFab(),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          buildNameFiled(),
          buildPicker(),
          buildDataPicker()
          // buildEmployeeRole(),
          // _buildBottomPicker(),
        ],
      ),
    );
  }

  Widget buildNameFiled() {
    return TextFormField(
      initialValue: manager.getName(),
      onChanged: manager.setEmployeeName,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        hintText: 'Employee Name',
        hintStyle: hintTextStyle,
        prefixIcon: const Icon(
          Icons.person_outline,
          color: textFieldIconColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: textFieldBoarderColor,
            strokeAlign: 5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      keyboardType: TextInputType.name,
      validator: ((validate) {
        if (validate == null) {
          return "Name Can't be empty";
        } else if (validate.length < 2) {
          return "Enter Valid Name";
        }
        return null;
      }),
    );
  }

  Widget buildPicker() {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker();
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: textFieldBoarderColor,
              )),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.work_outline_outlined,
                    color: textFieldIconColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    manager.getEmployeeRole() ?? 'Select Role',
                    style: const TextStyle(
                      color: hintTextColor,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: textFieldIconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPicker() {
    return Container(
      height: bottomSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: GestureDetector(
        onTap: () {},
        child: SafeArea(
          top: false,
          child: _buildCupertinoPicker(),
        ),
      ),
    );
  }

  Widget _buildCupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 50,
      children: items
          .map((item) => Center(
                child: Text(
                  item,
                  style: dropDownTextStyle,
                ),
              ))
          .toList(),
      onSelectedItemChanged: (index) {
        setState(() => value = index);
        manager.setEmployeeRole(items[index]);
      },
    );
  }

  Widget buildDataPicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Row(
        children: [
          _buildStartDate(),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward,
            color: textFieldIconColor,
          ),
          const SizedBox(width: 8),
          buildEndDate(),
        ],
      ),
    );
  }

  Widget _buildStartDate() {
    return Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.date_range_outlined),
        onPressed: () => _selectDate(context),
        label: Text(
          widget.flowType == EmployeeAddEditFlowType.add
              ? startDate
              : DateFormat('dd MMM yyyy').format(manager.getStartDOJ()),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget buildEndDate() {
    return Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.date_range_sharp),
        onPressed: () => _selectEndDate(context),
        label: Text(
          widget.flowType == EmployeeAddEditFlowType.add
              ? endDate
              : DateFormat('dd MMM yyyy').format(manager.getEndDOL()),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget buildFab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 90,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: 90,
          child: ElevatedButton(
            onPressed: () {
              if (manager.getName().isNotEmpty &&
                  manager.getEmployeeRole() != 'Select Role') {
                AddEmployeeLogic.addOrEditEmployeeToDataBase(
                  manager: manager,
                  ref: ref,
                  context: context,
                  flowType: widget.flowType,
                ).then((value) {
                  Navigator.pop(context);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Field\'s Can\'t be empty ')));
              }
            },
            child: Text(
              widget.flowType == EmployeeAddEditFlowType.add ? 'Save' : 'Edit',
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: manager.getStartDOJ(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != manager.getStartDOJ()) {
      setState(() {
        // _selectedStartDate = picked;
        manager.setStartDOJ(picked);
        startDate = DateFormat('dd MMM yyyy').format(manager.getStartDOJ());
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: manager.getEndDOL(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != manager.getEndDOL()) {
      setState(() {
        // _selectedEndDate = picked;
        manager.setStartDOL(picked);
        endDate = DateFormat('dd MMM yyyy').format(manager.getEndDOL());
      });
    }
  }
}
