import 'package:flutter/material.dart';

// ── Colour tokens ─────────────────────────────────────────────
abstract class _C {
  static const bg        = Color(0xFF13151A);
  static const panel     = Color(0xFF1C1F26);
  static const panelEdge = Color(0xFF262B35);
  static const accent    = Color(0xFF7C5CFC);
  static const accentDim = Color(0x267C5CFC);
  static const white     = Color(0xFFFFFFFF);
  static const label     = Color(0xFF4A5060);
  static const muted     = Color(0xFF6B7385);
  static const success   = Color(0xFF3EC98A);
}

// ── Interests data ────────────────────────────────────────────
const _interests = [
  'Algorithms', 'System Design', 'Open Source',
  'Code Review', 'Debugging',   'Performance',
  'Interview Prep', 'Side Projects', 'Career Growth',
  'Architecture',  'Testing',    'DevTools',
];

// ── Socials data ──────────────────────────────────────────────
const _socials = [
  ('Facebook',   Icons.facebook_rounded,       Color(0xFF1877F2), 'facebook.com/you'),
  ('Instagram',  Icons.camera_alt_rounded,     Color(0xFFE1306C), '@your_handle'),
  ('X (Twitter)',Icons.alternate_email_rounded, Color(0xFF1DA1F2), '@username'),
  ('Reddit',     Icons.reddit_rounded,          Color(0xFFFF4500), 'u/username'),
];

// =============================================================
//  ROOT
// =============================================================


// =============================================================
//  SCREEN
// =============================================================
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final Set<String> _selected = {};
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void _toggleInterest(String i) =>
      setState(() => _selected.contains(i) ? _selected.remove(i) : _selected.add(i));

  void _onSave() {
    setState(() => _saved = true);
    Future.delayed(const Duration(seconds: 2),
        () { if (mounted) setState(() => _saved = false); });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _C.bg,
        body: Column(
          children: [
            _TopBar(saved: _saved, onSave: _onSave),
            _AvatarHero(),
            const SizedBox(height: 4),
            _PillTabBar(controller: _tabs),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [
                  _BasicInfoTab(),
                  _InterestsTab(selected: _selected, onToggle: _toggleInterest),
                  _SocialTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
//  TOP BAR
// =============================================================
class _TopBar extends StatelessWidget {
  final bool saved;
  final VoidCallback onSave;
  const _TopBar({required this.saved, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _IconBtn(icon: Icons.arrow_back_ios_new_rounded),
          const Spacer(),
          const Text('Edit Profile',
              style: TextStyle(
                  color: _C.white, fontSize: 15, fontWeight: FontWeight.w700)),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            child: saved ? _savedBadge() : _saveButton(),
          ),
        ],
      ),
    );
  }

  Widget _savedBadge() => Container(
        key: const ValueKey('saved'),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _C.success.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _C.success.withOpacity(0.4)),
        ),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.check_rounded, color: _C.success, size: 14),
          SizedBox(width: 5),
          Text('Saved',
              style: TextStyle(
                  color: _C.success, fontSize: 13, fontWeight: FontWeight.w600)),
        ]),
      );

  Widget _saveButton() => GestureDetector(
        key: const ValueKey('save'),
        onTap: onSave,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF7C5CFC), Color(0xFF5B8DEF)]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: _C.accent.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 3))
            ],
          ),
          child: const Text('Save',
              style: TextStyle(
                  color: _C.white, fontSize: 13, fontWeight: FontWeight.w700)),
        ),
      );
}

// =============================================================
//  AVATAR HERO
// =============================================================
class _AvatarHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            width: 92,
            height: 92,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [_C.accent, Color(0x1A7C5CFC), _C.accent],
              ),
            ),
          ),
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _C.bg, width: 3),
              color: _C.panel,
              image: const DecorationImage(
                image: AssetImage('assets/images/png/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: _C.accent,
                shape: BoxShape.circle,
                border: Border.all(color: _C.bg, width: 2),
              ),
              child: const Icon(Icons.edit_rounded,
                  color: Colors.white, size: 13),
            ),
          ),
        ]),
        const SizedBox(height: 10),
        const Text('Alex Chen',
            style: TextStyle(
                color: _C.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3)),
        const Text('@alexchen_dev',
            style: TextStyle(
                color: _C.muted, fontSize: 13, fontFamily: 'monospace')),
      ]),
    );
  }
}

// =============================================================
//  PILL TAB BAR
// =============================================================
class _PillTabBar extends StatelessWidget {
  final TabController controller;
  const _PillTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _C.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.panelEdge),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: _C.accent,
          boxShadow: [
            BoxShadow(
                color: _C.accent.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: _C.white,
        unselectedLabelColor: _C.muted,
        labelStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.3),
        tabs: const [
          Tab(text: 'Basic Info'),
          Tab(text: 'Interests'),
          Tab(text: 'Social'),
        ],
      ),
    );
  }
}

// =============================================================
//  TAB 1 — BASIC INFO
// =============================================================
class _BasicInfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: _Field(label: 'First name', hint: 'Alex')),
          const SizedBox(width: 12),
          Expanded(child: _Field(label: 'Last name', hint: 'Chen')),
        ]),
        const SizedBox(height: 16),
        _Field(label: 'Username', hint: 'your_handle', prefix: '@'),
        const SizedBox(height: 16),
        _BioField(),
      ]),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final String? prefix;
  const _Field({required this.label, required this.hint, this.prefix});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label.toUpperCase(),
          style: const TextStyle(
              color: _C.label,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2)),
      const SizedBox(height: 6),
      TextField(
        style: const TextStyle(
            color: _C.white, fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: _C.panel,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          prefixText: prefix,
          prefixStyle: const TextStyle(
              color: _C.accent, fontSize: 14, fontFamily: 'monospace'),
          hintText: hint,
          hintStyle:
              TextStyle(color: _C.label.withOpacity(0.6), fontSize: 13),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _C.panelEdge)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _C.accent, width: 1.5)),
        ),
      ),
    ]);
  }
}

class _BioField extends StatefulWidget {
  @override
  State<_BioField> createState() => _BioFieldState();
}

class _BioFieldState extends State<_BioField> {
  int _len = 0;
  static const _max = 160;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Text('BIO',
            style: TextStyle(
                color: _C.label,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2)),
        const Spacer(),
        Text('$_len/$_max',
            style: const TextStyle(
                color: _C.accent,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600)),
      ]),
      const SizedBox(height: 6),
      TextField(
        maxLength: _max,
        minLines: 4,
        maxLines: 4,
        onChanged: (v) => setState(() => _len = v.length),
        style: const TextStyle(color: _C.white, fontSize: 14, height: 1.5),
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          filled: true,
          fillColor: _C.panel,
          hintText: 'Tell the community what you\'re building…',
          hintStyle:
              TextStyle(color: _C.label.withOpacity(0.6), fontSize: 13),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _C.panelEdge)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _C.accent, width: 1.5)),
        ),
      ),
    ]);
  }
}

// =============================================================
//  TAB 2 — INTERESTS
// =============================================================
class _InterestsTab extends StatelessWidget {
  final Set<String> selected;
  final void Function(String) onToggle;
  const _InterestsTab({required this.selected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            children: [
              TextSpan(text: '// ', style: TextStyle(color: _C.accent)),
              TextSpan(
                  text: 'select topics that match your work',
                  style: TextStyle(color: _C.muted)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${selected.length} topic${selected.length == 1 ? '' : 's'} selected',
          style: const TextStyle(
              color: _C.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: _interests
              .map((i) => _Chip(
                    label: i,
                    active: selected.contains(i),
                    onTap: () => onToggle(i),
                  ))
              .toList(),
        ),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: active ? _C.accentDim : _C.panel,
          border: Border.all(
              color: active ? _C.accent : _C.panelEdge,
              width: active ? 1.5 : 1),
          boxShadow: active
              ? [BoxShadow(
                  color: _C.accent.withOpacity(0.25),
                  blurRadius: 8,
                  spreadRadius: 1)]
              : null,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (active)
            const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(Icons.check_rounded, size: 13, color: _C.accent),
            ),
          Text(label,
              style: TextStyle(
                  color: active ? _C.white : _C.muted,
                  fontSize: 13,
                  fontWeight:
                      active ? FontWeight.w600 : FontWeight.w400)),
        ]),
      ),
    );
  }
}

// =============================================================
//  TAB 3 — SOCIAL LINKS
// =============================================================
class _SocialTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Your links',
            style: TextStyle(
                color: _C.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5)),
        const SizedBox(height: 4),
        const Text('Let others find you across platforms',
            style: TextStyle(color: _C.muted, fontSize: 13)),
        const SizedBox(height: 20),
        ..._socials.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _SocialRow(
                  label: s.$1, icon: s.$2, iconColor: s.$3, hint: s.$4),
            )),
      ]),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final String hint;
  const _SocialRow(
      {required this.label,
      required this.icon,
      required this.iconColor,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.panelEdge),
      ),
      child: Row(children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label.toUpperCase(),
                style: const TextStyle(
                    color: _C.label,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.3)),
            const SizedBox(height: 4),
            TextField(
              style: const TextStyle(
                  color: _C.white, fontSize: 13, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: hint,
                hintStyle: TextStyle(
                    color: _C.label.withOpacity(0.5), fontSize: 13),
              ),
            ),
          ]),
        ),
        Icon(Icons.open_in_new_rounded, color: _C.muted, size: 15),
      ]),
    );
  }
}

// =============================================================
//  SHARED
// =============================================================
class _IconBtn extends StatelessWidget {
  final IconData icon;
  const _IconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: _C.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _C.panelEdge),
      ),
      child: Icon(icon, color: _C.white, size: 16),
    );
  }
}