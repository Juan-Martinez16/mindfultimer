import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './bell_sound_card_widget.dart';

class BellSoundSelectorWidget extends StatelessWidget {
  final List<Map<String, dynamic>> bellSounds;
  final String selectedBellSound;
  final Function(String) onBellSoundChanged;

  const BellSoundSelectorWidget({
    Key? key,
    required this.bellSounds,
    required this.selectedBellSound,
    required this.onBellSoundChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bell Sound',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 2.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bellSounds.length,
          separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
          itemBuilder: (context, index) {
            final sound = bellSounds[index];
            return BellSoundCardWidget(
              soundName: sound["name"] as String,
              description: sound["description"] as String,
              waveformUrl: sound["waveform"] as String,
              audioUrl: sound["audioUrl"] as String,
              isSelected: selectedBellSound == sound["name"],
              onTap: () => onBellSoundChanged(sound["name"] as String),
            );
          },
        ),
      ],
    );
  }
}
