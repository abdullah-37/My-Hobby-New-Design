import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';

class BadgesPage extends StatefulWidget {
  const BadgesPage({super.key});

  @override
  State<BadgesPage> createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Badges',centerTitle: true,isLeading: true,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'Earned Badges',
                style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              childAspectRatio: 0.76,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _badgeItem(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCLw0Mwb8TF6vkgnwp05JP2Am-AC0HlUrH0bhYXHv_ehHLNb6MM5ctyAJbtd7nMdgjI3DSi8Hg6J0RjQ8NqHmltBKYmUAIqtm3I-0yFroPRKpW9c_oq7KBkJq2fx_M6DYmRa6w_mowILjOnOJeD9ueM9T0QdMCpcgt8VesCF32PYOfMbj3hf8kgSHwteD4U3rWnuLO0j8NH4BwDqSKOaQli1oIrovKPzSLF7vPurMf0xbRuuW51L2RO398G3tygGp57TkhVIiYFhzpk',
                  'First Timer',
                  'Join your first event',
                ),
                _badgeItem(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDzBYg62XFdUCq7Nk_hfeyExYNgejyRBOXm92kShVVObEHfAROGP3m_1X5lMWnt6YqeEkuAdawL6eprlEt348aP3Zhu894yKXNoaUOi7kBH8EKfJlgphKpEoxpxRB3BRQjoFHKBpIkHoGfzi76_ESG83icNJ2VH4WkuSW2um0M0i_iPtUYH3EKxL0UiIm3iCYz7bjatAfyKm3Chx_YK0kABSJL8crug2He11pHokfGFrdBrUoFTWjv_EsgEwY-Ak7lJCBdnjm_85F_U',
                  'Active Member',
                  'Attend 5 events',
                ),
                _badgeItem(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDjGL__8PTPRdaeilwHsb-f38KT3p8TVU8Ww46GUDuG8OAsbXgg0iQVUgA4Bk60gcOGEKqlBJv5sNvfGLO3Xmyk7UjM-WYKKr4fYv660qgXHS44EoRBZ4-O4ULD6ZvdjjMDWCRQuLIsp9m8YCDIC2Nb8sqotByNqfU_xv8G0bVSp1y-pmjc2LF7SpA4zN8oXUUxW3DpMomsXDgMvjcyk-3nPYklFbhnlxpThrhHW3weQcdrbWixxrRaSk3d4sH7HysjhfOsKcTyyzBj',
                  'Club Hero',
                  'Host an event',
                ),
                _badgeItem(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDu7QQoO5HKiMabw-6Lt_SmE7hGUt9_P1xcU_WATEOZTXksdk3T2aw_HV4XGWMqGiP2oUmE5b5ImYMKTDn9SDR1mRYfio3EVDeMWoRkQbCk7SygZpY91cj3-AY-TeLnLyIg57BrIItYlQcfj35mJWHEEir2DVowkqj3Pknm5N2KlbrID7FvVRhPWTGAyAPd7vt8aCdyONDO0GlwE_qF2UFJvFS4cuFo3JZPMiJ7tAoYRduuPeepU_u7k4lkA4Tslh-yElYrf3lbKWnI',
                  'Challenge Winner',
                  'Win a challenge',
                ),
                _badgeItem(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDjGL__8PTPRdaeilwHsb-f38KT3p8TVU8Ww46GUDuG8OAsbXgg0iQVUgA4Bk60gcOGEKqlBJv5sNvfGLO3Xmyk7UjM-WYKKr4fYv660qgXHS44EoRBZ4-O4ULD6ZvdjjMDWCRQuLIsp9m8YCDIC2Nb8sqotByNqfU_xv8G0bVSp1y-pmjc2LF7SpA4zN8oXUUxW3DpMomsXDgMvjcyk-3nPYklFbhnlxpThrhHW3weQcdrbWixxrRaSk3d4sH7HysjhfOsKcTyyzBj',
                  'Club Hero',
                  'Host an event',
                ),
                _badgeItem(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDu7QQoO5HKiMabw-6Lt_SmE7hGUt9_P1xcU_WATEOZTXksdk3T2aw_HV4XGWMqGiP2oUmE5b5ImYMKTDn9SDR1mRYfio3EVDeMWoRkQbCk7SygZpY91cj3-AY-TeLnLyIg57BrIItYlQcfj35mJWHEEir2DVowkqj3Pknm5N2KlbrID7FvVRhPWTGAyAPd7vt8aCdyONDO0GlwE_qF2UFJvFS4cuFo3JZPMiJ7tAoYRduuPeepU_u7k4lkA4Tslh-yElYrf3lbKWnI',
                  'Challenge Winner',
                  'Win a challenge',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badgeItem(String imageUrl, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4E7F97),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}