import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/my_activity_controller.dart';
import 'package:tech_talk/core/data/responses/Activity_History_Response.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class MyActivity extends GetView<ActivityController> {
  const MyActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      appBar: AppBar(
        backgroundColor: Appcolor.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Appcolor.white),
        title: const Text(
          'Activity',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: Obx(() {
        final isInitialLoad =
            controller.isLoading.value && controller.activityResponse.value == null;

        if (isInitialLoad) {
          return const _ActivitySkeleton();
        }

        final data = controller.activityResponse.value?.data ?? [];

        if (data.isEmpty) {
          return _EmptyActivity(onRefresh: controller.getActivity);
        }

        final groups = _groupByDay(data);

        return RefreshIndicator(
          color: Appcolor.accent,
          backgroundColor: Appcolor.panel,
          onRefresh: controller.getActivity,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            itemCount: groups.length,
            itemBuilder: (context, groupIndex) {
              final group = groups[groupIndex];
              return _DayGroup(
                label: group.label,
                activities: group.items,
                currentUserId: controller.currentUserId,
                onTapActivity: controller.openActivity,
              );
            },
          ),
        );
      }),
    );
  }
}

// ============================================================================
// تجميع الأنشطة حسب اليوم — بيرجع لستة مرتبة متل ما إجت من السيرفر أصلًا
// ============================================================================
class _ActivityDayGroup {
  final String label;
  final List<ActivityData> items;

  _ActivityDayGroup({required this.label, required this.items});
}

List<_ActivityDayGroup> _groupByDay(List<ActivityData> data) {
  final groups = <_ActivityDayGroup>[];

  for (final activity in data) {
    final label = _dayLabel(activity.createdAt);

    if (groups.isNotEmpty && groups.last.label == label) {
      groups.last.items.add(activity);
    } else {
      groups.add(_ActivityDayGroup(label: label, items: [activity]));
    }
  }

  return groups;
}

String _dayLabel(String isoString) {
  final date = DateTime.tryParse(isoString)?.toLocal();
  if (date == null) return 'Earlier';

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(date.year, date.month, date.day);
  final diff = today.difference(target).inDays;

  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';

  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

String _timeAgo(String isoString) {
  final date = DateTime.tryParse(isoString)?.toLocal();
  if (date == null) return '';

  final diff = DateTime.now().difference(date);
  if (diff.inSeconds < 60) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return '${date.day}/${date.month}/${date.year}';
}

// ============================================================================
// كتلة يوم واحد — عنوان اليوم + عناصر الأنشطة متل خط زمني (timeline)
// ============================================================================
class _DayGroup extends StatelessWidget {
  final String label;
  final List<ActivityData> activities;
  final int currentUserId;
  final void Function(ActivityData) onTapActivity;

  const _DayGroup({
    required this.label,
    required this.activities,
    required this.currentUserId,
    required this.onTapActivity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 6, left: 2),
          child: Text(
            label,
            style: const TextStyle(
              color: Appcolor.muted,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        for (int i = 0; i < activities.length; i++)
          _ActivityTile(
            activity: activities[i],
            isFirst: i == 0,
            isLast: i == activities.length - 1,
            currentUserId: currentUserId,
            onTap: () => onTapActivity(activities[i]),
          ),
      ],
    );
  }
}

// ============================================================================
// عنصر نشاط واحد — نقطة على الخط الزمني + جملة توضح شو صار
// ============================================================================
class _ActivityTile extends StatelessWidget {
  final ActivityData activity;
  final bool isFirst;
  final bool isLast;
  final int currentUserId;
  final VoidCallback onTap;

  const _ActivityTile({
    required this.activity,
    required this.isFirst,
    required this.isLast,
    required this.currentUserId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // تشخيص مؤقت - شوف بالضبط شو راجع من السيرفر
    print(
      '🔍 ACTIVITY: action="${activity.action}" | '
      'subject.type="${activity.subject.type}" | '
      'subject.id=${activity.subject.id} | '
      'meta=${activity.meta}',
    );

    final visual = _visualFor(activity.action);
    final isMe = activity.actor.id == currentUserId;
    final actorLabel = isMe ? 'You' : activity.actor.name;
    final subjectTitle = _subjectTitle(activity.meta);
    final isTappable = activity.subject.id != 0 &&
        (activity.subject.type.toLowerCase().contains('post') ||
            activity.subject.type.toLowerCase().contains('blog'));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- عمود الخط الزمني ----------
            SizedBox(
              width: 34,
              child: Column(
                children: [
                  Expanded(
                    child: isFirst
                        ? const SizedBox.shrink()
                        : Container(width: 2, color: Appcolor.panelEdge),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: visual.color.withOpacity(0.14),
                      shape: BoxShape.circle,
                      border: Border.all(color: visual.color.withOpacity(0.3)),
                    ),
                    child: Icon(visual.icon, size: 15, color: visual.color),
                  ),
                  Expanded(
                    child: isLast
                        ? const SizedBox.shrink()
                        : Container(width: 2, color: Appcolor.panelEdge),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // ---------- محتوى النشاط ----------
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isTappable ? onTap : null,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.panel,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Appcolor.panelEdge),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              color: Appcolor.white,
                              fontSize: 13.5,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: actorLabel,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: ' ${visual.verb} '),
                              TextSpan(
                                text: subjectTitle ??
                                    _subjectNounFor(activity.subject.type),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: subjectTitle != null
                                      ? Appcolor.white
                                      : Appcolor.muted,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _timeAgo(activity.createdAt),
                          style: const TextStyle(
                            color: Appcolor.muted,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// تحويل نوع الـ action لأيقونة + لون + فعل مناسب
// ============================================================================
class _ActionVisual {
  final IconData icon;
  final Color color;
  final String verb;

  const _ActionVisual({
    required this.icon,
    required this.color,
    required this.verb,
  });
}

_ActionVisual _visualFor(String rawAction) {
  final action = rawAction.toLowerCase();

  if (action.contains('unlike')) {
    return const _ActionVisual(
      icon: Icons.favorite_border_rounded,
      color: Appcolor.muted,
      verb: 'unliked',
    );
  }
  if (action.contains('like')) {
    return const _ActionVisual(
      icon: Icons.favorite_rounded,
      color: Appcolor.accent,
      verb: 'liked',
    );
  }
  if (action.contains('comment')) {
    return const _ActionVisual(
      icon: Icons.chat_bubble_rounded,
      color: Appcolor.accent,
      verb: 'commented on',
    );
  }
  if (action.contains('unfollow')) {
    return const _ActionVisual(
      icon: Icons.person_remove_rounded,
      color: Appcolor.muted,
      verb: 'unfollowed',
    );
  }
  if (action.contains('follow')) {
    return const _ActionVisual(
      icon: Icons.person_add_rounded,
      color: Appcolor.success,
      verb: 'started following',
    );
  }
  if (action.contains('unsave')) {
    return const _ActionVisual(
      icon: Icons.bookmark_border_rounded,
      color: Appcolor.muted,
      verb: 'removed a saved item',
    );
  }
  if (action.contains('save')) {
    return const _ActionVisual(
      icon: Icons.bookmark_rounded,
      color: Appcolor.accent,
      verb: 'saved',
    );
  }
  if (action.contains('blog')) {
    return const _ActionVisual(
      icon: Icons.article_rounded,
      color: Appcolor.success,
      verb: 'published',
    );
  }
  if (action.contains('post')) {
    return const _ActionVisual(
      icon: Icons.edit_note_rounded,
      color: Appcolor.success,
      verb: 'published',
    );
  }

  return const _ActionVisual(
    icon: Icons.bolt_rounded,
    color: Appcolor.muted,
    verb: 'did something',
  );
}

/// النص الافتراضي لو ما في عنوان صريح بالـ meta - هلق بيعتمد على
/// subject.type الحقيقي (نفس مصدر الحقيقة يلي بيستخدمو openActivity
/// للتنقّل)، مش على الـ action النصي زي قبل.
String _subjectNounFor(String subjectType) {
  final type = subjectType.toLowerCase();
  if (type.contains('blog')) return 'a blog';
  if (type.contains('post')) return 'a post';
  if (type.contains('user')) return 'a user';
  if (type.contains('comment')) return 'a comment';
  return 'something';
}

String? _subjectTitle(Map<String, dynamic> meta) {
  for (final key in ['title', 'post_title', 'blog_title', 'name', 'username']) {
    final value = meta[key];
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
  }
  return null;
}

// ============================================================================
// حالة فاضية — نفس روح باقي شاشات البروفايل
// ============================================================================
class _EmptyActivity extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _EmptyActivity({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Appcolor.accent,
      backgroundColor: Appcolor.panel,
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Appcolor.panel,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.history_rounded,
                        color: Appcolor.muted,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'No activity yet',
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Things you like, comment on, or save\nwill show up here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Appcolor.muted, fontSize: 12.5, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// سكيلتون تحميل — نبضة خفيفة بدل سبينر ثابت
// ============================================================================
class _ActivitySkeleton extends StatelessWidget {
  const _ActivitySkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Pulse(
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Appcolor.panel,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _Pulse(
                child: Container(
                  height: 62,
                  decoration: BoxDecoration(
                    color: Appcolor.panel,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Appcolor.panelEdge),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pulse extends StatefulWidget {
  final Widget child;
  const _Pulse({required this.child});

  @override
  State<_Pulse> createState() => _PulseState();
}

class _PulseState extends State<_Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: widget.child,
    );
  }
}