import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor ?? cs.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
          ),
          trailing ??
              Text(value,
                  style: tt.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
