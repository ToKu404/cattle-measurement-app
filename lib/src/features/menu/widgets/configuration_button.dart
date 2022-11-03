import 'package:cattle_app/core/routes/app_routes.dart';
import 'package:cattle_app/src/models/configuration_entity.dart';
import 'package:cattle_app/src/repositories/menu_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/color_const.dart';

class ConfigurationButton extends StatefulWidget {
  const ConfigurationButton({
    super.key,
  });

  @override
  State<ConfigurationButton> createState() => _ConfigurationButtonState();
}

class _ConfigurationButtonState extends State<ConfigurationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final provider = context.read<MenuHandler>();
        final initConfig = await provider.getConfigurationData();
        print(initConfig.jarak);
        Navigator.pushNamed(
          context,
          AppRoute.configuration,
          arguments: initConfig,
        );
      },
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.settings,
                color: Colors.black,
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
                  'Konfigurasi Kamera',
                  style: const TextStyle(
                      height: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
