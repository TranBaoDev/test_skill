import 'package:flutter/material.dart';
import '../../injection.dart';
import '../../data/repositories/bookmark_repository.dart';

class BookmarkButton extends StatefulWidget {
  final int lessonId;
  const BookmarkButton({super.key, required this.lessonId});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  final _repository = getIt<BookmarkRepository>();
  bool _isBookmarked = false;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await _repository.isBookmarked(widget.lessonId);
    if (mounted)
      setState(() {
        _isBookmarked = result;
        _isLoaded = true;
      });
  }

  Future<void> _toggle() async {
    // Optimistic update — phản hồi UI ngay, không chờ ghi DB
    setState(() => _isBookmarked = !_isBookmarked);
    await _repository.toggleBookmark(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) return const SizedBox(width: 24, height: 24);
    return IconButton(
      icon: Icon(
        _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
        color: _isBookmarked ? const Color(0xFF3D5CFF) : Colors.grey,
      ),
      onPressed: _toggle,
    );
  }
}
