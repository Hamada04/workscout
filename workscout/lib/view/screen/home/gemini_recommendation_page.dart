import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workscout/services/api_client.dart';

class GeminiRecommendationPage extends StatefulWidget {
  const GeminiRecommendationPage({super.key});

  @override
  State<GeminiRecommendationPage> createState() => _GeminiRecommendationPageState();
}

class _GeminiRecommendationPageState extends State<GeminiRecommendationPage> {
  String? _recommendation;
  bool _loading = false;
  bool _hasFetched = false;
  String? _errorMessage;

  Future<void> _fetchRecommendation() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      final response = await ApiClient.post('/ai/analyze-cv');
      setState(() {
        _recommendation = response['recommendation'] as String?;
        _hasFetched = true;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = _sanitizeError(e);
      });
    }
  }

  static const _errorMessages = <String, String>{
    '400': 'عذراً، الطلب غير صالح. يرجى التحقق من بياناتك والمحاولة مرة أخرى.',
    '401': 'انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى.',
    '403': 'عذراً، ليس لديك صلاحية الوصول إلى هذه الخدمة.',
    '429': 'عذراً، تم تجاوز حد الطلبات المؤقت من خوادم جوجل. يرجى المحاولة مرة أخرى بعد دقيقة.',
    '500': 'عذراً، حدث خطأ في الخادم. يرجى المحاولة لاحقاً.',
    '502': 'عذراً، حدث خطأ في الخادم. يرجى المحاولة لاحقاً.',
    '503': 'عذراً، حدث خطأ في الخادم. يرجى المحاولة لاحقاً.',
  };

  String _sanitizeError(dynamic error) {
    final msg = error.toString();

    // Stage 1: Technical content interceptor
    final isTechnical = msg.length > 200 || msg.contains('{') || msg.contains('[');
    if (isTechnical) {
      final code = RegExp(r'\b(4\d{2}|5\d{2})\b').firstMatch(msg)?.group(1);
      if (code != null && _errorMessages.containsKey(code)) {
        return _errorMessages[code]!;
      }
      if (msg.contains('Unauthorized')) return _errorMessages['401']!;
      return 'عذراً، حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
    }

    // Stage 2: Clean / short text handler
    if (msg.contains('Unauthorized')) return _errorMessages['401']!;
    return 'عذراً، حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Career Coach"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Analyzing your profile..."),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 48),
            SvgPicture.asset('assets/images/google-gemini.svg', width: 64, height: 64),
            const SizedBox(height: 24),
            Icon(Icons.error_outline, size: 48, color: Colors.orange[700]),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _fetchRecommendation,
              icon: const Icon(Icons.refresh),
              label: const Text("حاول مرة أخرى"),
            ),
          ],
        ),
      );
    }

    if (!_hasFetched) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/google-gemini.svg',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              "Get personalized career recommendations\npowered by Gemini AI",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _fetchRecommendation,
              icon: const Icon(Icons.auto_awesome),
              label: const Text("Get Recommendations"),
            ),
          ],
        ),
      );
    }

    if (_recommendation == null || _recommendation!.isEmpty) {
      return const Center(child: Text("No recommendations available"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/google-gemini.svg', width: 24, height: 24),
              const SizedBox(width: 8),
              const Text("Recommendations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Based on your profile and CV analysis",
            style: TextStyle(color: Colors.grey[600]),
          ),
          const Divider(height: 32),
          Text(
            _recommendation!,
            style: const TextStyle(fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 32),
          Center(
            child: OutlinedButton.icon(
              onPressed: _fetchRecommendation,
              icon: const Icon(Icons.refresh),
              label: const Text("Regenerate"),
            ),
          ),
        ],
      ),
    );
  }
}
