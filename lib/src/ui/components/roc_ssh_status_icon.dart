import 'package:flutter/material.dart';

import '../../VolumeControl/ssh_status.dart';

class SshStatusText extends StatelessWidget {
  final SSHStatus status;

  const SshStatusText({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    debugPrint('Icon Status: $status');  
    switch (status) {
      case SSHStatus.connected:
        color = Colors.green;
        break;
      case SSHStatus.connecting:
        color = Colors.orange;
        break;
      case SSHStatus.failed:
        color = Colors.red;
        break;
      case SSHStatus.disconnected:
        color = Color.fromARGB(255, 61, 119, 165);
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'SSH', // zamiast ikony
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
