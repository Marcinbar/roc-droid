import 'package:flutter/material.dart'; 

class VolumeBar extends StatelessWidget {
  final double volume; // 0.0 – 1.0
  final bool isMuted;
  final ValueChanged<double> onChanged;
  final VoidCallback? onMuteToggle;

  const VolumeBar({
    Key? key,
    required this.volume,
    required this.isMuted,
    required this.onChanged,
    this.onMuteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 0, 0, 0),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
          bottom: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          // Ikonka głośnika / mute
          IconButton(
            icon: Icon(
              isMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: onMuteToggle,
          ),

          // Tekst procentowy
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${(volume * 100).round()}%',
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // Suwak
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
              ),
              child: Slider(
                value: volume,
                min: 0.0,
                max: 1.0,
                onChanged: onChanged,
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
