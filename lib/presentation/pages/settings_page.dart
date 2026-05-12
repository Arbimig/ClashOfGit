import 'package:clashofclans/data/bloc/player_cubit.dart';
import 'package:clashofclans/data/bloc/switch_th_lvl_cubit.dart';
import 'package:clashofclans/data/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/internal/app_strings.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../internal/apps_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildAppearanceSection(context),
        const SizedBox(height: 16),
        _buildDefaultsSection(context),
        const SizedBox(height: 16),
        _buildDataSection(context),
        const SizedBox(height: 16),
        _buildAppInfoSection(context),
      ],
    );
  }

  Widget _buildAppearanceSection(BuildContext context) {
    return Card(
      color: themeData.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.appearance,
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, currentTheme) {
                final isDark = currentTheme.brightness == Brightness.dark;
                return SwitchListTile(
                  title: Text(
                    AppStrings.darkTheme,
                    style: themeData.textTheme.headlineMedium,
                  ),
                  subtitle: Text(
                    isDark ? 'Dark mode enabled' : 'Light mode enabled',
                    style: themeData.textTheme.displayMedium,
                  ),
                  value: isDark,
                  activeColor: themeData.colorScheme.secondary,
                  onChanged: (_) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultsSection(BuildContext context) {
    return Card(
      color: themeData.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Defaults',
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            BlocBuilder<ThLevlel, String>(
              builder: (context, currentLevel) {
                return ListTile(
                  title: Text(
                    AppStrings.defaultTHLevel,
                    style: themeData.textTheme.headlineMedium,
                  ),
                  subtitle: Text(
                    'TH$currentLevel',
                    style: themeData.textTheme.displayMedium,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showThLevelPicker(context, currentLevel);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThLevelPicker(BuildContext context, String currentLevel) {
    final levels = ['4', '5', '6', '7', '8', '9', '10', '11', '12', '13'];
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: themeData.cardColor,
          title: Text(
            'Select Town Hall Level',
            style: themeData.textTheme.headlineMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: levels.map((level) {
              return RadioListTile<String>(
                title: Text(
                  'TH$level',
                  style: themeData.textTheme.displayMedium,
                ),
                value: level,
                groupValue: currentLevel.replaceAll('th', ''),
                activeColor: themeData.colorScheme.secondary,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ThLevlel>().getLevel('${value}th');
                    _saveDefaultThLevel(value);
                  }
                  Navigator.pop(dialogContext);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _saveDefaultThLevel(String level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('default_th_level', level);
  }

  Widget _buildDataSection(BuildContext context) {
    return Card(
      color: themeData.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data',
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Text(
                AppStrings.clearAllPlayers,
                style: themeData.textTheme.headlineMedium,
              ),
              subtitle: Text(
                'Remove all locally saved player data',
                style: themeData.textTheme.displayMedium,
              ),
              trailing: const Icon(Icons.delete_outline, color: Colors.red),
              onTap: () {
                _showClearPlayersConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearPlayersConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: themeData.cardColor,
          title: Text(
            'Clear All Players',
            style: themeData.textTheme.headlineMedium,
          ),
          content: Text(
            'Are you sure you want to remove all saved players? This action cannot be undone.',
            style: themeData.textTheme.displayMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: themeData.textTheme.displayMedium,
              ),
            ),
            TextButton(
              onPressed: () async {
                await _clearAllPlayers(context);
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _clearAllPlayers(BuildContext context) async {
    final playerCubit = context.read<PlayerCubit>();
    final tags = await playerCubit.getTags();
    for (final tag in tags) {
      playerCubit.delete(tag);
    }
  }

  Widget _buildAppInfoSection(BuildContext context) {
    return Card(
      color: themeData.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.appInfo,
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Text(
                AppStrings.versionLabel,
                style: themeData.textTheme.headlineMedium,
              ),
              subtitle: Text(
                AppStrings.version,
                style: themeData.textTheme.displayMedium,
              ),
              leading: const Icon(Icons.info_outline),
            ),
            const Divider(),
            ListTile(
              title: Text(
                AppStrings.githubRepo,
                style: themeData.textTheme.headlineMedium,
              ),
              subtitle: Text(
                'View source code on GitHub',
                style: themeData.textTheme.displayMedium,
              ),
              leading: const Icon(Icons.code),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                // GitHub repository link
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                AppStrings.cocApi,
                style: themeData.textTheme.headlineMedium,
              ),
              subtitle: Text(
                'Powered by Clash of Clans API',
                style: themeData.textTheme.displayMedium,
              ),
              leading: const Icon(Icons.api),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                // Clash of Clans API link
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPageAppBar extends StatelessWidget with PrefAppBar {
  const SettingsPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeCubit = context.watch<ThemeCubit>();
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
      title: const Text(
        AppStrings.settings,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
