import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../injection.dart';
import '../../blocs/quiz/quiz_bloc.dart';
import '../../blocs/quiz/quiz_event.dart';
import '../../blocs/quiz/quiz_state.dart';
import '../../data/models/quiz_question.dart';

class QuizScreen extends StatelessWidget {
  final int quizId;
  final String title;

  const QuizScreen({super.key, required this.quizId, this.title = 'Quiz'});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(getIt())..add(QuizStarted(quizId)),
      child: _QuizView(title: title),
    );
  }
}

class _QuizView extends StatefulWidget {
  final String title;
  const _QuizView({required this.title});

  @override
  State<_QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<_QuizView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFFF3F4F8),
        elevation: 0,
        foregroundColor: const Color(0xFF1B1D28),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.questions.isEmpty) {
            return const Center(child: Text('Chưa có câu hỏi nào'));
          }
          return Column(
            children: [
              _buildProgressBar(state),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: state.questions.length,
                  onPageChanged: (i) {
                    context.read<QuizBloc>().add(QuizPageChanged(i));
                  },
                  itemBuilder: (context, index) {
                    return _QuestionPage(
                      question: state.questions[index],
                      questionNumber: index + 1,
                      totalQuestions: state.questions.length,
                    );
                  },
                ),
              ),
              _buildNavigationBar(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressBar(QuizState state) {
    final progress = state.questions.isEmpty
        ? 0.0
        : (state.currentIndex + 1) / state.questions.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Câu ${state.currentIndex + 1}/${state.questions.length}'
            ' • Đã trả lời: ${state.answeredCount}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF3D5CFF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context, QuizState state) {
    final isFirst = state.currentIndex == 0;
    final isLast = state.currentIndex == state.questions.length - 1;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed:
                  isFirst ? null : () => _goToPage(state.currentIndex - 1),
              child: const Text('Câu trước'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D5CFF)),
              onPressed:
                  isLast ? null : () => _goToPage(state.currentIndex + 1),
              child: Text(
                isLast ? 'Đã hết' : 'Câu tiếp',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToPage(int index) {
    // jumpToPage để chuyển câu NGAY LẬP TỨC, không animate chờ lâu
    // -> đáp ứng yêu cầu "chuyển câu nhanh" với 500-1000 câu
    _pageController.jumpToPage(index);
  }
}

class _QuestionPage extends StatefulWidget {
  final QuizQuestion question;
  final int questionNumber;
  final int totalQuestions;

  const _QuestionPage({
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
  });

  @override
  State<_QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<_QuestionPage>
    with AutomaticKeepAliveClientMixin {
  AudioPlayer? _audioPlayer;

  @override
  bool get wantKeepAlive =>
      false; // KHÔNG giữ state -> tránh phình RAM với 500-1000 câu

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String path) async {
    _audioPlayer ??= AudioPlayer();
    try {
      if (path.startsWith('http')) {
        await _audioPlayer!.setUrl(path);
      } else {
        await _audioPlayer!.setAsset(path);
      }
      await _audioPlayer!.play();
    } catch (_) {
      // Bỏ qua lỗi phát audio mock (file có thể chưa tồn tại)
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: BlocSelector<QuizBloc, QuizState, int?>(
        // CHỈ rebuild khi đáp án của ĐÚNG câu này thay đổi
        // -> chọn đáp án câu 500 không làm rebuild câu 1
        selector: (state) => state.answers[widget.question.id],
        builder: (context, selectedIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Câu ${widget.questionNumber}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3D5CFF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.question.question,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B1D28),
                ),
              ),
              if (widget.question.imagePath != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.question.imagePath!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      height: 160,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image_outlined,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ],
              if (widget.question.audioPath != null) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _playAudio(widget.question.audioPath!),
                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text('Nghe audio câu hỏi'),
                ),
              ],
              const SizedBox(height: 20),
              ...List.generate(widget.question.options.length, (i) {
                final isSelected = selectedIndex == i;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      context.read<QuizBloc>().add(
                            QuizAnswerSelected(widget.question.id, i),
                          );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3D5CFF).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF3D5CFF)
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: isSelected
                                ? const Color(0xFF3D5CFF)
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Text(widget.question.options[i])),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
