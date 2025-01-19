import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/menu_button.dart';
import '../widgets/options/controls_tab.dart';
import '../widgets/options/misc_tab.dart';
import '../utils/app_constants.dart';
import '../utils/options_constants.dart';
import '../models/key_binding.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  double _volume = 0.5;
  late Map<String, KeyBinding> _keyBindings;

  @override
  void initState() {
    super.initState();
    _initializeBindings();
  }

  void _initializeBindings() {
    _keyBindings = {
      'moveUp': KeyBinding(
        action: OptionsConstants.moveUpText,
        keys: OptionsConstants.defaultKeyBindings['moveUp']!,
      ),
      'moveDown': KeyBinding(
        action: OptionsConstants.moveDownText,
        keys: OptionsConstants.defaultKeyBindings['moveDown']!,
      ),
      'moveLeft': KeyBinding(
        action: OptionsConstants.moveLeftText,
        keys: OptionsConstants.defaultKeyBindings['moveLeft']!,
      ),
      'moveRight': KeyBinding(
        action: OptionsConstants.moveRightText,
        keys: OptionsConstants.defaultKeyBindings['moveRight']!,
      ),
      'fire': KeyBinding(
        action: OptionsConstants.fireText,
        keys: OptionsConstants.defaultKeyBindings['fire']!,
      ),
      'nova': KeyBinding(
        action: OptionsConstants.novaText,
        keys: OptionsConstants.defaultKeyBindings['nova']!,
      ),
      'pause': KeyBinding(
        action: OptionsConstants.pauseText,
        keys: OptionsConstants.defaultKeyBindings['pause']!,
      ),
    };
  }

  void _handleBindingChanged(String action, KeyBinding newBinding) {
    setState(() {
      _keyBindings[action] = newBinding;
    });
    // TODO: Save bindings to persistent storage
  }

  void _handleVolumeChanged(double value) {
    setState(() {
      _volume = value;
    });
    // TODO: Save volume to persistent storage
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 220,
          title: Text(
            AppConstants.menuOptionsText,
            style: TextStyle(
              color: AppConstants.textColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(
                  color: AppConstants.playerColor,
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: MenuButton(
              text: '← Back',
              onPressed: () => Navigator.of(context).pop(),
              width: 200,
              height: 40,
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(
                child: Text(
                  OptionsConstants.controlsTabText,
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  OptionsConstants.miscTabText,
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            indicatorColor: AppConstants.playerColor,
            indicatorWeight: OptionsConstants.tabIndicatorWeight,
            indicatorPadding: EdgeInsets.symmetric(
              horizontal: OptionsConstants.tabIndicatorPadding,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            border: Border.all(
              color: AppConstants.playerColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(AppConstants.uiPadding),
          child: TabBarView(
            children: [
              ControlsTab(
                bindings: _keyBindings,
                onBindingChanged: _handleBindingChanged,
              ),
              MiscTab(
                volume: _volume,
                onVolumeChanged: _handleVolumeChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
