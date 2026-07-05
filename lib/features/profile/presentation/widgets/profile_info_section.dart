import 'package:flutter/material.dart';

/// A vertical list of labelled info rows (Email, Mobile, Unit, etc.)
/// separated by subtle dividers. Each field has an orange label and
/// a bold black value — matching the profile design.
class ProfileInfoSection extends StatelessWidget {
  final String email;
  final String mobile;
  final String unit;
  final String organization;
  final String address;

  const ProfileInfoSection({
    super.key,
    required this.email,
    required this.mobile,
    required this.unit,
    required this.organization,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileInfoRow(label: 'Email:', value: email),
        _ProfileInfoRow(label: 'Mobile:', value: mobile),
        _ProfileInfoRow(label: 'Unit', value: unit),
        _ProfileInfoRow(label: 'Organization', value: organization),
        _ProfileInfoRow(label: 'Address:', value: address),
      ],
    );
  }
}

/// A single label + value row within the info section.
class _ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFF8C00),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
