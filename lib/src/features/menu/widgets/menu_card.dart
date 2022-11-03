import 'package:cattle_app/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const MenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 1),
              color: Colors.black.withOpacity(.1),
            ),
          ],
          color: Palette.gray1,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Palette.secondary,
                size: 24,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Palette.secondary),
                ),
                SizedBox(
                  height: 30,
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      height: 1,
                      color: Palette.gray4,
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
