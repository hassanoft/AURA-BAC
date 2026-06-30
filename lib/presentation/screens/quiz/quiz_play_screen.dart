import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../providers/providers.dart';
import '../../widgets/common/subject_color.dart';

class QuizPlayScreen extends ConsumerStatefulWidget {
  final String quizId;
  const QuizPlayScreen({super.key, required this.quizId});

  @override
  ConsumerState<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends ConsumerState<QuizPlayScreen> {
  Timer? _timer;
  int _secondsLeft = 30;
  bool _answered = false;
  int? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quiz = ref.read(quizByIdProvider(widget.quizId));
      if (quiz != null) {
        ref.read(quizStateProvider.notifier).startQuiz(quiz);
        _secondsLeft = quiz.timeLimitSeconds;
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = ref.read(quizStateProvider).quiz?.timeLimitSeconds ?? 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_secondsLeft > 0 && !_answered) {
          _secondsLeft--;
        } else if (_secondsLeft == 0 && !_answered) {
          _selectAnswer(-1); // time's up, no answer
        }
      });
    });
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedAnswer = index;
    });
    ref.read(quizStateProvider.notifier).answerQuestion(index);
  }

  void _nextQuestion() {
    final state = ref.read(quizStateProvider);
    if (state.quiz == null) return;

    if (state.currentIndex >= state.quiz!.questions.length - 1) {
      _finishQuiz();
    } else {
      ref.read(quizStateProvider.notifier).nextQuestion();
      setState(() {
        _answered = false;
        _selectedAnswer = null;
      });
      _startTimer();
    }
  }

  Future<void> _finishQuiz() async {
    _timer?.cancel();
    final result = await ref
        .read(quizStateProvider.notifier)
        .saveResult(const Uuid().v4());
    if (mounted) {
      context.pushReplacement(AppRoutes.quizResult, extra: result);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(quizStateProvider);
    final quiz = state.quiz;

    if (quiz == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = quiz.questions[state.currentIndex];
    final color = SubjectColor.forId(quiz.subjectId);
    final progress = (state.currentIndex + 1) / quiz.questions.length;

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      appBar: AppBar(
        title: Text(quiz.title, style: const TextStyle(fontSize: 15)),
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle),
          onPressed: () => _showExitDialog(context),
        ),
      ),
      body: Column(
        children: [
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${state.currentIndex + 1}/${quiz.questions.length}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    _TimerBadge(seconds: _secondsLeft, color: color),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.borderLight,
                    color: color,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: Text(
                      question.question,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1),

                  const SizedBox(height: 20),

                  ...List.generate(question.options.length, (i) {
                    final isCorrect = i == question.correctIndex;
                    final isSelected = i == _selectedAnswer;

                    Color bgColor = AppColors.backgroundLight;
                    Color borderColor = AppColors.borderLight;
                    Color textColor = AppColors.textPrimaryLight;
                    IconData? trailingIcon;

                    if (_answered) {
                      if (isCorrect) {
                        bgColor = AppColors.successLight;
                        borderColor = AppColors.success;
                        textColor = AppColors.success;
                        trailingIcon = Iconsax.tick_circle5;
                      } else if (isSelected) {
                        bgColor = AppColors.errorLight;
                        borderColor = AppColors.error;
                        textColor = AppColors.error;
                        trailingIcon = Iconsax.close_circle5;
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _selectAnswer(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: borderColor, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: borderColor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + i),
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  question.options[i],
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (trailingIcon != null)
                                Icon(trailingIcon, color: textColor, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: (80 * i).ms);
                  }),

                  if (_answered) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.infoLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Iconsax.info_circle,
                              color: AppColors.info, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              question.explanation,
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                height: 1.4,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(),
                  ],
                ],
              ),
            ),
          ),

          if (_answered)
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _nextQuestion,
                  style: FilledButton.styleFrom(backgroundColor: color),
                  child: Text(
                    state.currentIndex >= quiz.questions.length - 1
                        ? 'Voir les résultats'
                        : 'Question suivante',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quitter le quiz ?'),
        content: const Text(
            'Votre progression sera perdue si vous quittez maintenant.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuer'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('Quitter',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _TimerBadge extends StatelessWidget {
  final int seconds;
  final Color color;
  const _TimerBadge({required this.seconds, required this.color});

  @override
  Widget build(BuildContext context) {
    final isUrgent = seconds <= 5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isUrgent
            ? AppColors.error.withOpacity(0.12)
            : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.timer_1,
              size: 14, color: isUrgent ? AppColors.error : color),
          const SizedBox(width: 4),
          Text(
            '${seconds}s',
            style: TextStyle(
              color: isUrgent ? AppColors.error : color,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
