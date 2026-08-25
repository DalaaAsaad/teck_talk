import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class FieldSignUp extends StatefulWidget {
  final TextEditingController ctrl;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? trailing;
  final TextInputType? type;

  const FieldSignUp({
    required this.ctrl,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.trailing,
    this.type,
  });

  @override
  State<FieldSignUp> createState() => _FieldState();
}

class _FieldState extends State<FieldSignUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _glow;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _glow = CurvedAnimation(parent: _ac, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  void _onFocus(bool f) {
    setState(() => _focused = f);
    f ? _ac.forward() : _ac.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: TextStyle(
            color: _focused ? Appcolor.accent : Appcolor.label,
            fontSize: Responsive.sp(0.035),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          child: Text(widget.label.toUpperCase()),
        ),
        SizedBox(height: Responsive.hp(0.01)),
        // field box
        AnimatedBuilder(
          animation: _glow,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Appcolor.accent.withOpacity(0.18 * _glow.value),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: Focus(
            onFocusChange: _onFocus,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: Appcolor.panel,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _focused ? Appcolor.accent : Appcolor.panelEdge,
                  width: _focused ? 1.5 : 1.0,
                ),
              ),
              child: TextField(
                controller: widget.ctrl,
                obscureText: widget.obscure,
                keyboardType: widget.type,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: Responsive.sp(0.044),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    color: Appcolor.label,
                    fontSize: Responsive.sp(0.044),
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: Responsive.wp(0.024),
                      end: Responsive.wp(0.01),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: Icon(
                        widget.icon,
                        key: ValueKey(_focused),
                        color: _focused ? Appcolor.accent : Appcolor.muted,
                        size: Responsive.sp(0.054),
                      ),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(),
                  suffixIcon: widget.trailing,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Responsive.hp(0.02),
                    horizontal: Responsive.wp(0.024),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
