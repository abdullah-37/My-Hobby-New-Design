import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7EFF3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFF0E171B),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 48),
                        child: Text(
                          'Leaderboard',
                          style: TextStyle(
                            color: Color(0xFF0E171B),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.015,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Leaderboard List
            Expanded(
              child: ListView(
                children: const [
                  LeaderboardItem(
                    rank: 1,
                    name: 'Liam Carter',
                    points: 1200,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBWFSCLcAgn_RskEmQAyvpMp2LM5sxP5bbtxzPMGtnhNm0iPcoicEPAALe87TPY_biUY9eEulLf7Q7U9_Q-ByZZEYE9lnOrG7IklXsZh8AF-ftBe3MNAZ871E2nbMYAdlyrqnLYyefh6dIztoXFvZUTiVmCiVoK86wIADRi76E2VHD_Aif2mKOKAHZ2CJgtte8Hz3xgNyoeymHU7lEcWR9joWYoCJH133qCjCu6rJFrFUrqLxBZ3fhFB-aasoE1xTh49yJCRMREAECO',
                  ),
                  LeaderboardItem(
                    rank: 2,
                    name: 'Sophia Bennett',
                    points: 1150,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAQnhA3EuFOmi0_g1otf5YWuqHZ0FQPugIBADc8t3K0CBC_bktge32Bus3Hi25nv_L-NB0v3yzrmIvv3Q4adVdPj6J4LN81Jo1QeBdx4anJxtdRGdGdxiQn0XWGVqU_xQF_8hqFXy0X2zBG9WijDdqPQq93roVrj9MN92FAFXkKfVBxYb3Q3dmsdONWGmOXxgcYF719_BdBjiakLrMLHV67DeW1ICeONQgJMQw_2BgrOWCyGEDFfv1vGeZPuZYZbFUCUtaT88oLX8-5',
                  ),
                  LeaderboardItem(
                    rank: 3,
                    name: 'Ethan Walker',
                    points: 1100,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDHWZKSrNGzuOmYn2Ks-IGRfhbdtKh1kwnhct088p-ZprDGE89F3NqGlNgHtRDNm8GQu4rZYBGeAvs7b9ckXonMfvITGnHMzAJbLZwJGV9C2zqkG_slcCGhdXJa8gjW1_x3P19FKhlHHPh-BsgRlx3oGQe0KHEeP4WlDPt9z3Nc72YIr4274nxr_zgxcIiIr4a8YWT7ZywrjMumY4VheAr8mMWVo3FbnKhUQ7ChaG8o6zW2cr0lwQ4tW2DIuoumAM2ydoXvaHO_YkIG',
                  ),
                  LeaderboardItem(
                    rank: 4,
                    name: 'Olivia Hayes',
                    points: 1050,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCJTSvC1TuP8uebenl0Kl8SlNv5nLKmnzcJi70IBB1PVuWDRD13MqlsBDCQecIWYn1oU3NbF1N6L0e6G7OtEPko4mzp_E0hMVDuRKDNAdery6F0aeDav4IvYiIt3_qGLQz-__GCFdaz6iVW6OZoW-5K3QOfSsbGRWkjQpl9OhiJH_JnAc3CqjN8-anLOi5eNy1d_aBeAkPmyAs7Tizjl_BwyVMUg_fc4GKB5sRHf7K2dCq2uAl0wj9keuGXnoJaG5mdcBMt2joMot0O',
                  ),
                  LeaderboardItem(
                    rank: 5,
                    name: 'Noah Turner',
                    points: 1000,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCgC7TgmzCvHgLkOYFoBRrM0Vaa1ekhi4kgsKUj28N3o5xuhjMCgb06aj55Q5_JC8uDSThEhYffUfxPlH0hWR_e9jdlhcFCQjPN9eEyGHRqotu1TokOJnX2DmpwLqiBaAoGdVUbfaXuMglCstsF0EPM3sn8CM5tsJZLonBruAO8KEocuVAIsk3X_0Gveihype5e_CJlgEZ-y-pPB6AcwvqT2gnx57rtM-O1KkTOvXeAGuPEEXXDSbYOIpMe_vFR7604Dzjh06MSEd1_',
                  ),
                  LeaderboardItem(
                    rank: 6,
                    name: 'Ava Mitchell',
                    points: 950,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC0ZADZfswDTpBMStpANJeD74u4wDA-Pbaa0BVOa0E5PI7gZOlyIfHBw1ptBZBY08ujsdZglmocQ_eO0rWTMF3UKYOGbGdlJgas21GoJbn7C4NmeqSr7FrEb06_uTscjpX_7NiiSeERSWXQNpE98H23QinzLg9tDsHlL4EIxLFU-b5vt-Q5as_NIUgA8HYDo4DIrwIIAYbSEeAVDM66yTWeC7GJrvUB3gGyBMwfeO1NyuLZfJwicDG4IA8gNYS89egxOzKqu-W4qvAB',
                  ),
                  LeaderboardItem(
                    rank: 7,
                    name: 'Lucas Reed',
                    points: 900,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCBNG-yWzE5A8Gr7q2kyJqouQgG0_Ny76aJLpXZz3OjCi_njZveQaP8VLDLk06mEHasLY4FEpda_xNicu6jM3DhYoSdcjsr0513_P3ppcXXvqcYUCBqsupo57ANtD8JjHBdn-o2zPMeszXZevRKHM5r4jcY7XMyR0_z60hDtTHvIBOEA0Go3XE7zwvGMFJ817Z98tiZUEOuwfDYs5sV9Yv8gNw3_tAKUMwfUFqfREMNvGYpVXb07IRadmOpdwUJDS4inhOq1CtxxgN2',
                  ),
                  LeaderboardItem(
                    rank: 8,
                    name: 'Isabella Foster',
                    points: 850,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAiT0F-7-mojpEKwoP1p3MHbTVQLhy8PbIWvOGKr2eHT_Do4KTVahVfneOAN15IA9M5k7hdakMGnQIHEB9W9bFIsOpQ-qVp8Oz7xVewKiPaxS2ky-i2N1Xjh8yZQHAmcYhBsx5kXSTduEPVBRzG8PpMFhHgClrA9k7vLIX7wgrfaSTUmNvk0u3GmLi6pA3H9bxrXouEvUGkDHiNAEn7-ovlD2f9TH5mCCTdpNPlKTBXBAMmCRjf6878pDY2fOPycUY4tEQ1zIrATAUz',
                  ),
                  LeaderboardItem(
                    rank: 9,
                    name: 'Jackson Cole',
                    points: 800,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCwmdax047BmFJQ4tfJ4KBcRgjsaH3UxoWQXT2hvnEMhDhLTnIL0pTPkZplNO-GIOnHab38-Zhu4rgKAjou-UDo8z_S_J2nApxq48IhPD9JWRtX0e_jtAcwLfdOGyxjtmw2C-D_puVIVgbez5BcxDvIPg11CHsmlxDK0oNypatrC2d18_SSHJstYYGN0qC0-0YR5LoUYb2y0FVyVXmjl68trLJOnXyIIr1L2Kk9Um8b40KSzfHy3TIP5pMTinozKRNMK_G4eWIgutCK',
                  ),
                  LeaderboardItem(
                    rank: 10,
                    name: 'Mia Harper',
                    points: 750,
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBk9vcdRxUjyZ54snsOzihUjXng2B-hVn0PiR6jFO2mz8yXhIfRswfLEN6fdtNTxf9uQT53vHDiioCNpc9te5KyCZpe0MMOX-jma67vQM26RsABhPYtmTLdjLW5mPAb5Ob_t_XYTJC7EeNhogVHfW3kyMTcFFSSm5OOlb1xhZ7TyRVo0mgGqQ6xTrsQph8Gcev12uccLwu_pevyg74Nd36kS6f2aPioKJbZDLaoXUeXrKQiop9YZxWB3fyEto5BE0i-lzUpkY7uF1am',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final String imageUrl;

  const LeaderboardItem({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Color(0xFF0E171B),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '$points points',
                    style: const TextStyle(
                      color: Color(0xFF4E7F97),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Text(
            '#$rank',
            style: const TextStyle(
              color: Color(0xFF0E171B),
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}