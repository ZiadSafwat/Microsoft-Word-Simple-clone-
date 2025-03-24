import 'dart:convert';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'desktop_editor.dart';
import 'mobile_editor.dart';

class Editor extends StatefulWidget {
  const Editor({
    super.key,
    required this.jsonString,
    required this.onEditorStateChange,
    this.editorStyle,
    this.textDirection = TextDirection.ltr,
  });

  final String jsonString; // ✅ Corrected type (String instead of Future<String>)
  final EditorStyle? editorStyle;
  final void Function(EditorState editorState) onEditorStateChange;
  final TextDirection textDirection;

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  bool isInitialized = false;
  EditorState? editorState;
  WordCountService? wordCountService;

  int wordCount = 0;
  int charCount = 0;
  int selectedWordCount = 0;
  int selectedCharCount = 0;

  @override
  void didUpdateWidget(covariant Editor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.jsonString != widget.jsonString) {
      _initializeEditor();
    }
  }

  void _initializeEditor() {
    isInitialized = true;
    editorState = EditorState(
      document: Document.fromJson(
        Map<String, Object>.from(json.decode(widget.jsonString)),
      ),
    );

    editorState!.logConfiguration
      ..handler = debugPrint
      ..level = AppFlowyEditorLogLevel.all;

    editorState!.transactionStream.listen((event) {
      if (event.$1 == TransactionTime.after) {
        widget.onEditorStateChange(editorState!);
      }
    });

    widget.onEditorStateChange(editorState!);
    _registerWordCounter();
  }

  void _registerWordCounter() {
    wordCountService?.removeListener(_onWordCountUpdate);
    wordCountService?.dispose();

    wordCountService = WordCountService(editorState: editorState!)..register();
    wordCountService!.addListener(_onWordCountUpdate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onWordCountUpdate();
    });
  }

  void _onWordCountUpdate() {
    setState(() {
      wordCount = wordCountService!.documentCounters.wordCount;
      charCount = wordCountService!.documentCounters.charCount;
      selectedWordCount = wordCountService!.selectionCounters.wordCount;
      selectedCharCount = wordCountService!.selectionCounters.charCount;
    });
  }

  @override
  void dispose() {
    editorState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized || editorState == null) {
      _initializeEditor();
    }

    if (UniversalPlatform.isDesktopOrWeb) {
      return DesktopEditor(
        editorState: editorState!,
        textDirection: widget.textDirection,
      );
    } else if (UniversalPlatform.isMobile) {
      return MobileEditor(editorState: editorState!);
    }

    return const SizedBox.shrink();
  }
}
