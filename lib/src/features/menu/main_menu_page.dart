// ignore_for_file: use_build_context_synchronously

import 'package:cattle_app/core/constants/color_const.dart';
import 'package:cattle_app/core/routes/app_routes.dart';
import 'package:cattle_app/src/features/menu/widgets/configuration_button.dart';
import 'package:cattle_app/src/features/menu/widgets/menu_card.dart';
import 'package:cattle_app/src/models/configuration_entity.dart';
import 'package:cattle_app/src/repositories/data_handler.dart';
import 'package:cattle_app/src/repositories/menu_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final prov2 = context.read<DataHandler>();
    prov2.init();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuHandler>();
    final prov2 = context.read<DataHandler>();

    void setConfigurationTemp(ConfigurationEntity data) {
      prov2.setJarakKamera(data.jarak);
      prov2.setPanjangGambar(data.panjang);
      prov2.setPanjangMeter(data.panjangMeter);
      prov2.setPanjangPixel(data.panjangPixel);
    }

    return Scaffold(
      backgroundColor: Palette.primary,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Pengukuran Berat Sapi',
                style: TextStyle(
                  color: Palette.gray1,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.gray1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ConfigurationButton(),
                    const SizedBox(
                      height: 12,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 12,
                    ),
                    MenuCard(
                      icon: Icons.dataset,
                      onTap: () async {
                        final data = await provider.getConfigurationData();

                        setConfigurationTemp(data);
                        if (data.jarak.isNotEmpty) {
                          provider.setMenuId(2);
                          Navigator.pushNamed(context, AppRoute.loginMbc);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Konfigurasi Kamera Terlebih Dahulu'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      title: 'Database Sapi',
                      subtitle: 'Pengukuran dari database sapi',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MenuCard(
                      icon: Icons.perm_data_setting_sharp,
                      onTap: () async {
                        final data = await provider.getConfigurationData();
                        setConfigurationTemp(data);
                        if (data.jarak.isNotEmpty) {
                          provider.setMenuId(1);
                          Navigator.pushNamed(context, AppRoute.sideViewIntro);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Konfigurasi Kamera Terlebih Dahulu'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      title: 'Pengukuran Bebas',
                      subtitle: 'Pengukuran data sapi secara langsung',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MenuCard(
                      icon: Icons.dataset,
                      onTap: () async {
                        final data = await provider.getConfigurationData();
                        setConfigurationTemp(data);
                        if (data.jarak.isNotEmpty) {
                          provider.setMenuId(2);
                          Navigator.pushNamed(context, AppRoute.loginSimkeu);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Konfigurasi Kamera Terlebih Dahulu'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      title: 'Data Pelatihan',
                      subtitle: 'Pengukuran untuk data pelatihan',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
