import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../domain/entities/category_action_item.dart';
import '../../domain/entities/category_detail.dart';

class CategoryLocalDataSource {
  static final Map<String, CategoryDetail> _categoryData = {
    "Approval Center": const CategoryDetail(
      title: "Approval Center",
      icon: Icons.check_circle,
      iconColor: Colors.green,
      actions: [
        CategoryActionItem(
          title: 'Leave Approvals',
          routeId: 'leave_approvals',
        ),
        CategoryActionItem(
          title: 'pr / po Approvals',
          routeId: 'overtime_approvals',
        ),
        CategoryActionItem(
          title: 'ir  Approvals',
          routeId: 'letter_approvals',
        ),
        CategoryActionItem(
          title: 'invoice Approvals',
          routeId: 'loan_approvals',
        ),
      ],
    ),

    "Jobs & Recruitment": const CategoryDetail(
      title: 'Jobs & Recruitment',
      icon: Iconsax.people5,
      iconColor: Color(0xFF607D8B),
      actions: [
       CategoryActionItem(
    title: 'Job Description',
    routeId: 'job_description',
  ),
  CategoryActionItem(
    title: 'Apply For A Job',
    routeId: 'apply_for_a_job',
  ),
  CategoryActionItem(
    title: 'Recruitment Request',
    routeId: 'recruitment_request',
  ),
      ],
    ),
    "Training & Certificates": const CategoryDetail(
      title: 'Training & Certificates',
      icon: Iconsax.teacher5,
      iconColor: Color(0xFF29B6F6),
      actions: [
        CategoryActionItem(
          title: 'My Qualification',
          routeId: 'my_qualification',
        ),
        CategoryActionItem(
          title: 'Employee Learning',
          routeId: 'employee_learning',
        ),
        CategoryActionItem(
          title: 'In-House Training',
          routeId: 'in_house_training',
        ),
        CategoryActionItem(
          title: 'Local & International Training',
          routeId: 'local_and_international_training',
        ),
        CategoryActionItem(
          title: 'Training And Travel Request',
          routeId: 'training_and_travel_request',
        ),
        CategoryActionItem(
          title: 'Future Skills Training Request',
          routeId: 'future_skills_training_request',
        ),
        CategoryActionItem(
          title: 'Training Report - Jtg',
          routeId: 'training_report_jtg',
        ),
        CategoryActionItem(
          title: 'Upload Professional Certificate',
          routeId: 'upload_professional_certificate',
        ),
        CategoryActionItem(
          title: 'Request New Professional Certificate',
          routeId: 'request_new_professional_certificate',
        ),
        CategoryActionItem(
          title: 'Orange Scholarship',
          routeId: 'orange_scholarship',
        ),
      ],
    ),
    "Internal Communication": const CategoryDetail(
      title: 'Internal Communication',
      icon: Iconsax.message5,
      iconColor: Color(0xFFFF6B35),
      actions: [
         CategoryActionItem(
      title: 'Intranet',
      routeId: 'intranet',
    ),
    CategoryActionItem(
      title: 'Orange Radio',
      routeId: 'orange_radio',
    ),
    CategoryActionItem(
      title: 'Plazza',
      routeId: 'plazza',
    ),
    CategoryActionItem(
      title: 'Wellbeing',
      routeId: 'wellbeing',
    ),
    CategoryActionItem(
      title: 'Internal Communication Requests',
      routeId: 'internal_communication_requests',
    ),
    CategoryActionItem(
      title: 'Thank You Card',
      routeId: 'thank_you_card',
    ),
      ],
    ),
    'Payroll & Letters': const CategoryDetail(
      title: 'Payroll & Letters',
      icon: Iconsax.document_text5,
      iconColor: Color(0xFF65B4E3),
      actions: [
        CategoryActionItem(
          title: 'Employee Letter',
          routeId: 'employee_letter',
        ),
        CategoryActionItem(
          title: 'Certificate Salary Letter',
          routeId: 'certificate_salary_letter',
        ),
        CategoryActionItem(
          title: 'Deductions Letter',
          routeId: 'deductions_letter',
        ),
        CategoryActionItem(
          title: 'Guarantees Letter',
          routeId: 'guarantees_letter',
        ),
        CategoryActionItem(
          title: 'Income Tax Sheet',
          routeId: 'income_tax_sheet',
        ),
        CategoryActionItem(title: 'Salary Slip', routeId: 'salary_slip'),
        CategoryActionItem(
          title: 'Salary Transfer',
          routeId: 'salary_transfer',
        ), CategoryActionItem(
          title: 'Salary Transfer (conditinal)',
          routeId: 'salary_transfer',
        ), CategoryActionItem(
          title: 'Salary Transfer continuity',
          routeId: 'salary_transfer',
        ), CategoryActionItem(
          title: 'provident fund slip',
          routeId: 'salary_transfer',
        ), CategoryActionItem(
          title: 'orange money extra amount',
          routeId: 'salary_transfer',
        ), CategoryActionItem(
          title: 'family offers',
          routeId: 'salary_transfer',
        ),
      ],
    ),
    'Attendance & Overtime': const CategoryDetail(
      title: 'Attendance & Overtime',
      icon: Iconsax.timer_15,
      iconColor: Color(0xFFA67BC5),
      actions: [
        CategoryActionItem(
          title: 'Leave Approvals',
          routeId: 'leave_approvals',
        ),
        CategoryActionItem(
          title: 'Absence Management',
          routeId: 'absence_management',
        ),
        CategoryActionItem(
          title: 'Time Attendance Tracking',
          routeId: 'time_attendance_tracking',
        ),
        CategoryActionItem(
          title: 'Annual Leaves Remaining Balance',
          routeId: 'annual_leaves_remaining_balance',
        ),
        CategoryActionItem(title: 'JTG Overtime', routeId: 'jtg_overtime'),
        CategoryActionItem(
          title: 'Current Overtime Balance',
          routeId: 'current_overtime_balance',
        ),
      ],
    ),
    'Objectives & Appraisal': const CategoryDetail(
      title: 'Objectives & Appraisal',
      icon: Iconsax.award,
      iconColor: Color(0xFF4CAF50),
      actions: [
        CategoryActionItem(
          title: 'Propose My Objectives',
          routeId: 'propose_my_objectives',
        ),
        CategoryActionItem(
          title: 'View My Evaluation & Objectives',
          routeId: 'view_my_evaluation_objectives',
        ),
        CategoryActionItem(
          title: 'My Team Objectives',
          routeId: 'my_team_objectives',
        ),
        CategoryActionItem(
          title: 'My Team Evaluation',
          routeId: 'my_team_evaluation',
        ),
      ],
    ),
    'Employee Benefits': const CategoryDetail(
      title: 'Employee Benefits',
      icon: Iconsax.gift5,
      iconColor: Color(0xFFFFC107),
      actions: [
        CategoryActionItem(
          title: 'Employee Mobile Subsidy',
          routeId: 'employee_mobile_subsidy',
        ),
        CategoryActionItem(
          title: 'Request For Orange Family Offers',
          routeId: 'request_orange_family_offers',
        ),
        CategoryActionItem(title: 'Nursery', routeId: 'nursery'),
        CategoryActionItem(title: 'Housing Loan', routeId: 'housing_loan'),
        CategoryActionItem(
          title: 'Private Car Entry',
          routeId: 'private_car_entry',
        ),
      ],
    ),
    'Health Insurance': const CategoryDetail(
      title: 'Health & Insurance',
      icon: Iconsax.heart5,
      iconColor: Color(0xFFF396D1),
      actions: [
        CategoryActionItem(
          title: 'Vaccination Status',
          routeId: 'vaccination_status',
        ),
        CategoryActionItem(
          title: 'Health Insurance Beneficiary',
          routeId: 'health_insurance_beneficiary',
        ),
        CategoryActionItem(
          title: 'Health Insurance Study Documents',
          routeId: 'health_insurance_study_documents',
        ),
        CategoryActionItem(
          title: 'Chronic Disease',
          routeId: 'chronic_disease',
        ),
        CategoryActionItem(
          title: 'Claim Out Of Medical Network',
          routeId: 'claim_out_of_medical_network',
        ),
        CategoryActionItem(
          title: 'Health Insurance Debit Letter',
          routeId: 'health_insurance_debit_letter',
        ),
        CategoryActionItem(
          title: 'Outpatient Usage Report',
          routeId: 'outpatient_usage_report',
        ),
      ],
    ),
  };

  CategoryDetail? getCategoryDetail(String categoryTitle) {
    return _categoryData[categoryTitle];
  }
}