import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  final random = Random(42);
  final types = ['video', 'audio', 'pdf', 'image', 'quiz'];

  final courses = List.generate(20, (c) {
    final lessonCount = 100 + random.nextInt(101);
    return {
      'id': c + 1,
      'title': 'Khóa học ${c + 1}: Chủ đề mẫu',
      'thumbnailPath': 'assets/images/course_${(c % 5) + 1}.png',
      'lessons': List.generate(lessonCount, (l) {
        final type = types[l % types.length];
        return {
          'id': (c + 1) * 10000 + l + 1,
          'courseId': c + 1,
          'title': 'Bài ${l + 1}: Nội dung $type',
          'type': type,
          'contentPath': _pathFor(type, l),
          'durationMs': type == 'video' || type == 'audio'
              ? 180000 + random.nextInt(300000)
              : null,
        };
      }),
    };
  });

  File('assets/mock/courses.json')
      .writeAsStringSync(jsonEncode({'courses': courses}));

  // ---- Sinh 5 ngân hàng câu hỏi riêng biệt, ID không trùng nhau giữa các bank ----
  const bankCount = 5;
  const questionsPerBank =
      150; // 5 x 150 = 750 câu, nằm trong khoảng 500-1000 theo yêu cầu

  for (var bank = 1; bank <= bankCount; bank++) {
    final idOffset = (bank - 1) * 10000; // đảm bảo ID không đụng giữa các file
    final questions = List.generate(questionsPerBank, (i) {
      final globalIndex = idOffset + i + 1;
      return {
        'id': globalIndex,
        'bankId': bank,
        'question': 'Ngân hàng $bank - Câu ${i + 1}: Đáp án nào đúng?',
        'imagePath':
            i % 3 == 0 ? 'assets/images/quiz_${(i % 10) + 1}.png' : null,
        'audioPath':
            i % 4 == 0 ? 'assets/audios/quiz_${(i % 10) + 1}.mp3' : null,
        'options': ['Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D'],
      };
    });

    File('assets/mock/quiz_bank_$bank.json')
        .writeAsStringSync(jsonEncode({'questions': questions}));
  }

  final totalLessons =
      courses.fold<int>(0, (sum, c) => sum + (c['lessons'] as List).length);
  print('Da sinh ${courses.length} khoa hoc, tong $totalLessons bai hoc.');
  print(
      'Da sinh $bankCount ngan hang quiz, moi ngan hang $questionsPerBank cau (tong ${bankCount * questionsPerBank} cau).');
}

String _pathFor(String type, int index) {
  switch (type) {
    case 'video':
      const videoUrls = [
        'https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4',
        'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      ];
      return videoUrls[index % videoUrls.length];
    case 'audio':
      return 'assets/audios/sample.mp3';
    case 'pdf':
      return 'assets/pdfs/sample.pdf';
    case 'image':
      return 'assets/images/sample.png';
    default:
      return '';
  }
}
