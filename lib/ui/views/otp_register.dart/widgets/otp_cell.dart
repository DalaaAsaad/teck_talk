import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class OtpCell extends StatefulWidget {
  final TextEditingController ctrl;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final double size;

  const OtpCell({
    required this.ctrl,
    required this.focusNode,
    required this.onChanged,
    required this.size,
  });

  @override
  State<OtpCell> createState() => _OtpCellState();
}

class _OtpCellState extends State<OtpCell> with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _glow;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _glow = CurvedAnimation(parent: _ac, curve: Curves.easeOut);

    widget.focusNode.addListener(() {
      final f = widget.focusNode.hasFocus;
      setState(() => _focused = f);
      f ? _ac.forward() : _ac.reverse();
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size * 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Appcolor.accent.withOpacity(0.22 * _glow.value),
                blurRadius: 16,
              ),
            ],
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: _focused ? Appcolor.accentDim : Appcolor.panel,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _focused ? Appcolor.accent : Appcolor.panelEdge,
                width: _focused ? 1.5 : 1.0,
              ),
            ),
            child: Center(
              child: TextField(
                controller: widget.ctrl,
                focusNode: widget.focusNode,
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: widget.size * 0.42,
                  color: _focused ? Appcolor.accent : Appcolor.white,
                  fontWeight: FontWeight.w700,
                ),
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        );
      },
    );
  }
}
