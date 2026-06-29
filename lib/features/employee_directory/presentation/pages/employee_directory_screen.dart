import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/directory_search_bar.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_list_item.dart';

class Employee {
  final String name;
  final String position;
  final String imageUrl;
  final String email;
  final String mobile;
  final String unit;
  final String organization;
  final String address;

  const Employee({
    required this.name,
    required this.position,
    required this.imageUrl,
    this.email = '',
    this.mobile = '',
    this.unit = '',
    this.organization = '',
    this.address = '',
  });
}

const List<Employee> _mockEmployees = [
  Employee(
    name: 'Nicola Fanous',
    position: 'Digital Sales Director',
    imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=256',
    email: 'nicola.fanous@orange.com',
    mobile: '0777000855',
    unit: 'CBU',
    organization: 'Digital Sales Directorate',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Sara Haddad',
    position: 'HR Business Partner',
    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=256',
    email: 'sara.haddad@orange.com',
    mobile: '0799123456',
    unit: 'HR',
    organization: 'Human Resources Directorate',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Ahmad Khalil',
    position: 'Network Engineer',
    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=256',
    email: 'ahmad.khalil@orange.com',
    mobile: '0788654321',
    unit: 'TN',
    organization: 'Technology & Networks',
    address: 'Amman, Shmeisani, NOC',
  ),
  Employee(
    name: 'Omar Nasser',
    position: 'Senior Software Developer',
    imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=256',
    email: 'omar.nasser@orange.com',
    mobile: '0770112233',
    unit: 'IT',
    organization: 'IT Directorate',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Layla Mansour',
    position: 'Marketing Manager',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
    email: 'layla.mansour@orange.com',
    mobile: '0791445566',
    unit: 'CBU',
    organization: 'Marketing Directorate',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Khaled Rahim',
    position: 'Finance Analyst',
    imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=256',
    email: 'khaled.rahim@orange.com',
    mobile: '0785998877',
    unit: 'Finance',
    organization: 'Finance Directorate',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Rania Azar',
    position: 'Legal Counsel',
    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=256',
    email: 'rania.azar@orange.com',
    mobile: '0799887766',
    unit: 'Legal',
    organization: 'Legal & Regulatory',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Fadi Jarrar',
    position: 'Project Manager',
    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=256',
    email: 'fadi.jarrar@orange.com',
    mobile: '0770334455',
    unit: 'PMO',
    organization: 'Project Management Office',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Dana Khoury',
    position: 'Customer Experience Lead',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1b28ce?q=80&w=256',
    email: 'dana.khoury@orange.com',
    mobile: '0788223344',
    unit: 'CBU',
    organization: 'Customer Experience',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Tariq Abed',
    position: 'Security Specialist',
    imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=256',
    email: 'tariq.abed@orange.com',
    mobile: '0791556677',
    unit: 'IT',
    organization: 'Information Security',
    address: 'Amman, Shmeisani, NOC',
  ),
  Employee(
    name: 'Hana Sabbagh',
    position: 'Training Coordinator',
    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=256',
    email: 'hana.sabbagh@orange.com',
    mobile: '0785112233',
    unit: 'HR',
    organization: 'Learning & Development',
    address: 'Amman, Abdali, HQ',
  ),
  Employee(
    name: 'Zaid Hamdan',
    position: 'Data Analyst',
    imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=256',
    email: 'zaid.hamdan@orange.com',
    mobile: '0770889900',
    unit: 'BI',
    organization: 'Business Intelligence',
    address: 'Amman, Abdali, HQ',
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
