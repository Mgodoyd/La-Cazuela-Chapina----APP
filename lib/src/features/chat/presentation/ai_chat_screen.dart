import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../data/ai_chat_api.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final List<_AiMessage> _messages = <_AiMessage>[];
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final SpeechToText _speech = SpeechToText();

  bool _speechReady = false;
  bool _listening = false;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      final ready = await _speech.initialize();
      if (!mounted) return;
      setState(() => _speechReady = ready);
    } catch (_) {
      if (!mounted) return;
      setState(() => _speechReady = false);
    }
  }

  @override
  void dispose() {
    _speech.stop();
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat IA'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Hola, soy tu asistente. Pregúntame sobre producción, inventario o ventas y te ayudo.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final alignment = message.isUser ? Alignment.centerRight : Alignment.centerLeft;
                      final bubbleColor = message.isUser
                          ? Theme.of(context).colorScheme.primary.withAlpha((255 * 0.85).toInt())
                          : Theme.of(context).colorScheme.surfaceContainerHighest;
                      final textColor = message.isUser ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant;
                      return Align(
                        alignment: alignment,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: bubbleColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(message.text, style: TextStyle(color: textColor)),
                        ),
                      );
                    },
                  ),
          ),
          _buildComposer(context),
        ],
      ),
    );
  }

  Widget _buildComposer(BuildContext context) {
    final theme = Theme.of(context);
    final canListen = !_sending && _speechReady;
    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.all(12),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              tooltip: canListen
                  ? (_listening ? 'Detener dictado' : 'Dictar con voz')
                  : 'Dictado no disponible',
              onPressed: canListen ? _toggleListening : null,
              icon: Icon(_listening ? Icons.stop_circle_rounded : Icons.mic_rounded),
              color: _listening ? theme.colorScheme.error : theme.colorScheme.primary,
            ),
            Expanded(
              child: TextField(
                controller: _inputCtrl,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: const InputDecoration(
                  hintText: 'Escribe tu pregunta...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _sending
                ? const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(strokeWidth: 2.4),
                  )
                : IconButton(
                    tooltip: 'Enviar',
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send_rounded, color: theme.colorScheme.primary),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleListening() async {
    if (_listening) {
      await _stopListening();
      return;
    }
    bool hasPermission = false;
    try {
      hasPermission = await _speech.hasPermission;
    } catch (_) {
      hasPermission = false;
    }
    if (!_speechReady || !hasPermission) {
      final ready = await _speech.initialize();
      if (!mounted) return;
      setState(() => _speechReady = ready);
      hasPermission = ready ? await _speech.hasPermission : false;
      if (!ready || !hasPermission) {
        return;
      }
    }
    setState(() => _listening = true);
    await _speech.listen(onResult: _onSpeechResult);
  }

  Future<void> _stopListening() async {
    if (_listening) {
      await _speech.stop();
      setState(() => _listening = false);
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;
    setState(() {
      _inputCtrl.text = result.recognizedWords;
      _inputCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: _inputCtrl.text.length),
      );
    });
  }

  Future<void> _sendMessage() async {
    final prompt = _inputCtrl.text.trim();
    if (prompt.isEmpty || _sending) return;
    setState(() {
      _messages.add(_AiMessage(isUser: true, text: prompt));
      _inputCtrl.clear();
      _sending = true;
    });
    await _scrollToBottom();
    try {
      final api = ref.read(aiChatApiProvider);
      final response = await api.sendMessage(message: prompt);
      setState(() {
        _messages.add(_AiMessage(isUser: false, text: response.trim()));
      });
    } catch (error) {
      setState(() {
        _messages.add(
          _AiMessage(
            isUser: false,
            text: 'No pude procesar la solicitud. Inténtalo de nuevo. Detalles: $error',
          ),
        );
      });
    } finally {
      setState(() => _sending = false);
      await _scrollToBottom();
    }
  }

  Future<void> _scrollToBottom() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (!_scrollCtrl.hasClients) return;
    _scrollCtrl.animateTo(
      _scrollCtrl.position.maxScrollExtent + 64,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}

class _AiMessage {
  _AiMessage({required this.isUser, required this.text});
  final bool isUser;
  final String text;
}

