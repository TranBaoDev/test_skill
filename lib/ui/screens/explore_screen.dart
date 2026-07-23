import 'package:flutter/material.dart';
import '../../data/models/ui_models.dart';
import '../../injection.dart';
import '../../data/repositories/course_repository.dart';
import 'lesson_list_screen.dart';

class ExploreScreen extends StatelessWidget {
  final String title;
  final SectionType sectionType;

  const ExploreScreen({
    super.key,
    required this.title,
    required this.sectionType,
  });

  static const _palette = [
    Color(0xFF8FEDA8),
    Color(0xFFF2EA8C),
    Color(0xFFC9A8F5),
    Color(0xFFF5B97A),
    Color(0xFF9AD0F5),
    Color(0xFFF5A8C9),
    Color(0xFFF5A8A0),
    Color(0xFF8FF0E0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: FutureBuilder(
                future: getIt<CourseRepository>().getAllCourses(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final courses = snapshot.data!;
                  if (courses.isEmpty) {
                    return const Center(child: Text('Chưa có môn học nào'));
                  }
                  final subjects = List.generate(courses.length, (i) {
                    return SubjectItem(
                      id: courses[i].id,
                      label: courses[i].title,
                      color: _palette[i % _palette.length],
                    );
                  });
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: subjects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.66,
                    ),
                    itemBuilder: (context, index) {
                      return _SubjectCard(
                        subject: subjects[index],
                        onTap: () => _openLessons(context, subjects[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openLessons(BuildContext context, SubjectItem subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonListScreen(
          courseId: subject.id,
          typeFilter: sectionType.lessonTypeFilter,
          screenTitle: subject.label,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1B1D28)),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B1D28),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final SubjectItem subject;
  final VoidCallback onTap;
  const _SubjectCard({required this.subject, required this.onTap});

  static const _features = [
    (Icons.groups_rounded, 'Cơ hội học nhóm'),
    (Icons.wifi_rounded, 'Học mọi lúc mọi nơi'),
    (Icons.note_alt_outlined, 'Ghi chú bài học'),
    (Icons.videocam_rounded, 'Lớp học trực tuyến'),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 12),
            decoration: BoxDecoration(
              color: subject.color,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Text(
                  subject.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B1D28),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        subject.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      ..._features.map((f) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Icon(f.$1,
                                    size: 12, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    f.$2,
                                    style: const TextStyle(fontSize: 9),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE7E8EE),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Text(
              subject.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
