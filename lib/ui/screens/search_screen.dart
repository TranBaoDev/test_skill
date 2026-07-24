import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/lesson_extensions.dart';
import '../../injection.dart';
import '../../blocs/search/search_bloc.dart';
import '../../blocs/search/search_event.dart';
import '../../blocs/search/search_state.dart';
import '../../data/models/lesson.dart';
import 'video_player_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(getIt()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1B1D28)),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Color(0xFF9A9DAE)),
                  hintText: 'Tìm kiếm bài học...',
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  context.read<SearchBloc>().add(SearchQueryChanged(query));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const _StatusMessage(
            icon: Icons.search,
            message: 'Nhập từ khóa để tìm bài học',
          );
        }
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchEmpty) {
          return _StatusMessage(
            icon: Icons.search_off,
            message: 'Không tìm thấy kết quả cho "${state.query}"',
          );
        }
        if (state is SearchLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemExtent: 72,
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              return _SearchResultTile(lesson: state.results[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _StatusMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  const _StatusMessage({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final Lesson lesson;
  const _SearchResultTile({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_iconFor(lesson.type), color: const Color(0xFF3D5CFF)),
      title: Text(lesson.displayTitle),
      subtitle: Text(lesson.type),
      onTap: () {
        if (lesson.type == 'video') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => VideoPlayerScreen(lesson: lesson)),
          );
        }
      },
    );
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'audio':
        return Icons.audiotrack;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'image':
        return Icons.image;
      case 'quiz':
        return Icons.quiz;
      default:
        return Icons.book;
    }
  }
}
