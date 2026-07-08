import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
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

class EmployeeDirectoryScreen extends StatefulWidget {
  const EmployeeDirectoryScreen({super.key});

  @override
  State<EmployeeDirectoryScreen> createState() => _EmployeeDirectoryScreenState();
}

class _EmployeeDirectoryScreenState extends State<EmployeeDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _getRelevanceScore(Employee e, String query) {
    if (query.isEmpty) return 0;
    final q = query.toLowerCase();

    final nameLower = e.name.toLowerCase();
    final positionLower = e.position.toLowerCase();
    final unitLower = e.unit.toLowerCase();
    final orgLower = e.organization.toLowerCase();
    final mobileLower = e.mobile.toLowerCase();

    // 1. First Name / Full Name starts directly with the query (Score: 100)
    if (nameLower.startsWith(q)) {
      return 100;
    }

    // 2. Last Name or any name word starts with the query (Score: 80)
    final nameWords = nameLower.split(' ');
    if (nameWords.any((word) => word.startsWith(q))) {
      return 80;
    }

    // 3. Department, Unit, or Position starts with the query (Score: 60)
    if (positionLower.startsWith(q) || unitLower.startsWith(q) || orgLower.startsWith(q)) {
      return 60;
    }
    final posWords = positionLower.split(' ');
    final orgWords = orgLower.split(' ');
    if (posWords.any((w) => w.startsWith(q)) || orgWords.any((w) => w.startsWith(q))) {
      return 50;
    }

    // 4. Mobile number starts with the query (Score: 40)
    if (mobileLower.startsWith(q)) {
      return 40;
    }

    // 5. Contains as a substring (Score: 10) - placed at the very bottom
    if (nameLower.contains(q) || positionLower.contains(q) || unitLower.contains(q) || orgLower.contains(q)) {
      return 10;
    }

    return 0; // No match
  }

  List<Employee> get _filteredEmployees {
    if (_searchQuery.trim().isEmpty) {
      return _mockEmployees;
    }
    final query = _searchQuery.trim();

    final scored = _mockEmployees
        .map((e) => MapEntry(e, _getRelevanceScore(e, query)))
        .where((entry) => entry.value > 0)
        .toList();

    // Sort descending by relevance score, then alphabetically
    scored.sort((a, b) {
      final scoreComparison = b.value.compareTo(a.value);
      if (scoreComparison != 0) return scoreComparison;
      return a.key.name.compareTo(b.key.name);
    });

    return scored.map((entry) => entry.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    final employees = _filteredEmployees;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            "Employee Directory",
            style: TextStyle(
              color: appColors.primaryText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ),
        DirectorySearchBar(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          onClear: () {
            _searchController.clear();
            setState(() {
              _searchQuery = '';
            });
          },
        ),
        Expanded(
          child: employees.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: employees.length,
                  separatorBuilder: (context, index) => Divider(
                    color: appColors.dividerColor,
                    height: 1,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  itemBuilder: (context, index) {
                    return EmployeeListItem(employee: employees[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 64,
            color: appColors.secondaryText,
          ),
          const SizedBox(height: 16),
          Text(
            "No employees found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: appColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "No results matching \"$_searchQuery\"",
            style: TextStyle(
              fontSize: 14,
              color: appColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
