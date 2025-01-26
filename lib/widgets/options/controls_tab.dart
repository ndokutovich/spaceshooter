import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/key_binding.dart';
import '../../utils/options_constants.dart';
import '../../utils/constants/style_constants.dart';

class ControlsTab extends StatefulWidget {
  final Map<String, KeyBinding> bindings;
  final Function(String, KeyBinding) onBindingChanged;

  const ControlsTab({
    super.key,
    required this.bindings,
    required this.onBindingChanged,
  });

  @override
  State<ControlsTab> createState() => _ControlsTabState();
}

class _ControlsTabState extends State<ControlsTab> {
  String? _listeningAction;
  List<LogicalKeyboardKey> _newKeys = [];

  void _startListening(String action) {
    setState(() {
      _listeningAction = action;
      _newKeys = [];
    });
    HapticFeedback.mediumImpact();
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (_listeningAction == null || event is! RawKeyDownEvent) return;

    if (!_newKeys.contains(event.logicalKey)) {
      setState(() {
        _newKeys = [event.logicalKey];
      });
      HapticFeedback.lightImpact();
      _finishBinding();
    }
  }

  void _finishBinding() {
    if (_listeningAction != null && _newKeys.isNotEmpty) {
      final currentBinding = widget.bindings[_listeningAction]!;
      widget.onBindingChanged(
        _listeningAction!,
        currentBinding.copyWith(keys: List.from(_newKeys)),
      );
    }
    setState(() {
      _listeningAction = null;
      _newKeys = [];
    });
    HapticFeedback.mediumImpact();
  }

  Widget _buildBindingButton(String action, KeyBinding binding) {
    final isListening = _listeningAction == action;
    final displayText = isListening
        ? _newKeys.isEmpty
            ? 'Press a key...'
            : _newKeys.map((k) => KeyBinding.getKeyDisplayName(k)).join(' / ')
        : binding.keyText;

    return Container(
      width: OptionsConstants.bindingButtonWidth,
      margin:
          const EdgeInsets.only(bottom: OptionsConstants.controlItemSpacing),
      child: Row(
        children: [
          SizedBox(
            width: OptionsConstants.actionLabelWidth,
            child: Text(
              binding.action,
              style: TextStyle(
                color: StyleConstants.textColor,
                fontSize: OptionsConstants.bindingTextSize,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTapDown: (_) => _startListening(action),
            child: Container(
              width: OptionsConstants.keyBindWidth,
              height: OptionsConstants.bindingButtonHeight,
              decoration: BoxDecoration(
                color: isListening
                    ? StyleConstants.playerColor
                        .withOpacity(StyleConstants.opacityLow)
                    : Colors.black45,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isListening
                      ? StyleConstants.playerColor
                      : StyleConstants.textColor
                          .withOpacity(StyleConstants.opacityMedium),
                ),
              ),
              child: Center(
                child: Text(
                  displayText,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isListening
                        ? StyleConstants.playerColor
                        : StyleConstants.textColor,
                    fontSize: OptionsConstants.bindingTextSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlGroup(String title, List<String> actions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: StyleConstants.playerColor,
            fontSize: OptionsConstants.categoryTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: OptionsConstants.controlItemSpacing),
        Column(
          children: actions
              .map((action) =>
                  _buildBindingButton(action, widget.bindings[action]!))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: _handleKeyPress,
      child: GestureDetector(
        onTapDown: (_) => _finishBinding(),
        behavior: HitTestBehavior.translucent,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(OptionsConstants.tabIndicatorPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildControlGroup(
                OptionsConstants.movementControlsText,
                ['moveUp', 'moveDown', 'moveLeft', 'moveRight'],
              ),
              const SizedBox(height: OptionsConstants.controlGroupSpacing),
              _buildControlGroup(
                OptionsConstants.actionControlsText,
                ['fire', 'nova'],
              ),
              const SizedBox(height: OptionsConstants.controlGroupSpacing),
              _buildControlGroup(
                OptionsConstants.systemControlsText,
                ['pause'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
