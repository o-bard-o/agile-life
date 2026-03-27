import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_card.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    const Color(0xFF61A88B),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agile Life',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '장기 목표를 Goal → Milestone → Sprint → Task 구조로 쪼개고, 회고와 XP 시스템으로 다음 사이클을 더 잘 설계하는 개인 목표 관리 앱 초안입니다.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _IntroChip(label: 'Material 3'),
                      _IntroChip(label: 'Riverpod'),
                      _IntroChip(label: 'Mock Data'),
                      _IntroChip(label: 'Sprint Retrospective'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이번 초안에서 보는 내용',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16),
                  _FeatureBullet(
                    title: '목표 계층 구조',
                    message: '장기 Goal을 Milestone과 Sprint로 나눠 관리합니다.',
                  ),
                  _FeatureBullet(
                    title: '진행 중 스프린트',
                    message: '오늘의 Task와 진행률을 한 화면에서 확인합니다.',
                  ),
                  _FeatureBullet(
                    title: '회고 + 게이미피케이션',
                    message: 'Retrospective 작성과 XP/Level/Badge 흐름을 포함합니다.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppCard(
              color: colorScheme.secondaryContainer.withValues(alpha: 0.8),
              child: Text(
                '현재 저장소는 mock 데이터 기반 초안입니다. Firebase Auth / Firestore 연동, 실제 디바이스 테스트, 사용자 평가 단계는 이후 진행 예정입니다.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: () {
                ref
                    .read(appStateControllerProvider.notifier)
                    .completeOnboarding();
                context.go(AppRoutes.dashboardPath);
              },
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('Mock 데이터로 둘러보기'),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroChip extends StatelessWidget {
  const _IntroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _FeatureBullet extends StatelessWidget {
  const _FeatureBullet({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.check_circle_rounded, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(height: 1.5),
                children: [
                  TextSpan(
                    text: '$title  ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: message),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
