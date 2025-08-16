import 'dart:io';

import 'package:case1/features/auth/data/model/user_model.dart';
import 'package:case1/features/profile/presentation/bloc/profile.state.dart';
import 'package:case1/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:case1/features/profile/presentation/bloc/profile_event.dart';
import 'package:case1/features/profile/data/models/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });

      // TODO: Burada seçilen resmi backend'e veya local storage'a kaydet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(
              child: Text(
                'Hata: ${state.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          if (state.user == null) {
            return const Center(
              child: Text(
                'Kullanıcı bulunamadı',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final User user = state.user!;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                // Profil Resmi
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage!)
                          : const AssetImage('assets/images/default_profile.png')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
  onTap: () {
    context.read<ProfileBloc>().add(PickProfileImage());
  },
  child: CircleAvatar(
    radius: 60,
    backgroundColor: Colors.grey[300],
    backgroundImage: state.profileImage != null
        ? FileImage(state.profileImage!)
        : const AssetImage('assets/images/default_profile.png') as ImageProvider,
  ),
),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Bilgiler kartlar halinde, ikonlu ve başlıklı
                ProfileInfoCard(
                  icon: Icons.person,
                  label: 'Ad Soyad',
                  value: user.name,
                ),

                const SizedBox(height: 16),

                ProfileInfoCard(
                  icon: Icons.phone,
                  label: 'Telefon',
                  value: user.phone,
                ),

                const SizedBox(height: 16),

                ProfileInfoCard(
                  icon: Icons.email,
                  label: 'E-posta',
                  value: user.email,
                ),

                const SizedBox(height: 32),

                // Profili Düzenle Butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Profili düzenleme sayfasına yönlendirme
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Profili Düzenle'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
