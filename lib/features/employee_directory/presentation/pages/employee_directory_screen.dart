import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/directory_search_bar.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_list_item.dart';

class Employee {
  final String name;
  final String position;
  final String imageUrl;

  const Employee({
    required this.name,
    required this.position,
    required this.imageUrl,
  });
}

const List<Employee> _mockEmployees = [
  Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=256',
  ),
  Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=256',
  ),
  Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=256',
  ),
  Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=256',
  ),
  Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),Employee(
    name: 'Employee Name',
    position: 'Current Position',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
  ),
];

class EmployeeDirectoryScreen extends StatelessWidget {
  const EmployeeDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            "Employee Directory", 
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const DirectorySearchBar(),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: _mockEmployees.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xFFEEEEEE),
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              return EmployeeListItem(employee: _mockEmployees[index]);
            },
          ),
        ),
      ],
    );
  }
}
