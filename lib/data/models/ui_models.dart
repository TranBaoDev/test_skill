import 'package:flutter/material.dart';

class HomeSectionItem {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;
  final SectionType sectionType;

  const HomeSectionItem({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.iconColor,
    required this.sectionType,
  });
}

class SubjectItem {
  final int id;
  final String label;
  final Color color;

  const SubjectItem(
      {required this.id, required this.label, required this.color});
}

enum SectionType { course, exam, video, ebook }

extension SectionTypeX on SectionType {
  String? get lessonTypeFilter {
    switch (this) {
      case SectionType.exam:
        return 'quiz';
      case SectionType.video:
        return 'video';
      case SectionType.ebook:
        return 'pdf';
      case SectionType.course:
        return null;
    }
  }
}
