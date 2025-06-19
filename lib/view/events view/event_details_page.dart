import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryTextColor = const Color(0xFF111518);
    final secondaryTextColor = const Color(0xFF60768a);
    final borderColor = const Color(0xFFDBE1E6);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF111518)),
                      onPressed: () => Get.back(),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 48),
                          child: Text(
                            'Event Details',
                            style: TextStyle(
                              color: primaryTextColor,
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
          
              // Event Cover Image
              Container(
                height: 218,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBbRuqdt4efaPcVwdSm-Z-q1qKXz8qUfHpQ_uQthm4I8flm5CK4ZohntKscHlDyXOqpNP8sGP6MO83pAPMrFlyhBabwrb11XjtxqJBH3BzprzRU8UP4Q3-uBNVcd3YzyIwIROoEtO0Uq1rZ_gyew6TyRjZeM1kaXTamxXHWue88pQ7lu-741mtr4aVSs3vru2LR2BWku2NCtzC8pXKkXV19hGonEVFSRX0NXETGGxwk1zLua5d2D9E1kmdczTHVUiRvlFsAzSDoFH81',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          
              // Event Title and Description
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  'Mountain Hiking Adventure',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(
                  'Join us for an exhilarating hike through the scenic mountain trails. Experience breathtaking views and challenge yourself with a rewarding climb.',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryTextColor,
                    height: 1.5,
                  ),
                ),
              ),
          
              // Details Section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _detailRow('Date', 'Saturday, July 20', borderColor),
                    _detailRow('Time', '9:00 AM - 3:00 PM', borderColor),
                    _detailRow('Location', 'Mountain Trailhead', borderColor),
                  ],
                ),
              ),
          
              // About the Event
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'About the Event',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(
                  'This event is perfect for outdoor enthusiasts and those looking to connect with nature. We\'ll provide guidance and support throughout the hike, ensuring a safe and enjoyable experience for all participants.',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryTextColor,
                    height: 1.5,
                  ),
                ),
              ),
          
              // Organizer
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Organizer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuD_-L8a8z69ar1gOK5kMsBwICqjBL_Kd2eS3ynLMcGBv44T4RpbU3ccKbJdCq_4K3D9S7I9Yle0SNxUQszPX98jK7rlCZD10SnS_IUGPKg9WoiO3BOr4t6tyBLrRxZom6ORQBNpnSZUkrv0AweGhUNxkotrxVS2PNJB2-yU4Web4ju6vNWmyJXi6k4F70HxofUxQ9f3MMRFHLu5QD9Ixrus1cOPw5B0Up6baH4ezMNW8nDt6KC1DUe5FETOgd5krmIPXUUr2nyMvgA-',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ethan Walker',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: primaryTextColor,
                          ),
                        ),
                        Text(
                          'Trailblazers Club',
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          
              // Attendees
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              //   child: Text(
              //     'Attendees',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //       color: primaryTextColor,
              //       letterSpacing: -0.015,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 56,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     children: [
              //       _attendeeAvatar(
              //         'https://lh3.googleusercontent.com/aida-public/AB6AXuCwNG7xTRkHF81tVz5WS0EsGfnDgOtVDHYhusRvyHxOZ4mt2IUHizQQR8drEptptf4efkytI0PnQBSDM3agiMVQes1bWQjfAiwMzoJp-5oBPqHJfEsIq4NN42sOEqWjyLBnK7D8cvYrkFcw_DvBxxKJAACK8bMqjNrWxbOlWCDncTfZLj2zn_AOnCB-HgTt7bpGAShJuuhIbW2HfLNk1ta4_U_purnavxBwl-dENdV6GlW4f9GVqGzYJ0Uci5zcLfHhPNrl2OFRi8E4',
              //       ),
              //       _attendeeAvatar(
              //         'https://lh3.googleusercontent.com/aida-public/AB6AXuCuCd3Oiz5FRWAl3dn59KCDEEE3F6cDkWtsC_kf6hK2JVP5IPUvHr7R6_KeGjd05RPMcfoPvGoBoxMpUFtkL1GmYL57XOE9IzvNgfi-0ktVjNcBiTVNoVrcMVNpJ1XaqJtmRCVE-kVs_PUFmPEXmviC4sbEonk88v5BKox-QY98XeHgqrTGPMJiWGTMwG8GlM6rtuSkCWJQMmsh6w0DHyrNMsv6FsVFUy1IT-pZVd_ng26I_XtvmuxVNN5QMrsX7qwSH1Yr3C-Oizlf',
              //       ),
              //       _attendeeAvatar(
              //         'https://lh3.googleusercontent.com/aida-public/AB6AXuCGzO_YVSTYIaPJXIq3kEjQOpexlbOrvM-vCVH-gitC8coYNp-SCmKVXngz4SX_dE1Xe8_fhv5k5eGIMvYsprZldHm1WTmk9GC1VwyrMBLZ3nI58nGFEwqKAA7YksuO_xLV9hxuP_m3oNpWfSfAdsZw9emXIisn3l4-86XFX2WW1pFeFBDHAW1gWwEIswU8JWjR2w1gSpz7xmo_L1fU_H7MAE9B4H51-HLSkTADl_83l5RBWGXP1AlU_NzV-qvoZm2frerUYBgU9G6e',
              //       ),
              //       _attendeeAvatar(
              //         'https://lh3.googleusercontent.com/aida-public/AB6AXuC42qknzU3H5ixXvLuOY_wAluUTK707aIAT9gK4P6lrT5dbzOds5MHVFFNi6zWjdtP2K_kLx4jF3oaDgSA-ucKEsxP8dsQ1yx4Wz_9KhlEYU_YEurdb0sIyGZYDNaffl1kAgCDyjC2h4spyrFc38X0jKbf_egpyOtPChRuLQXy0ri5zNRNm2fGtouqO2_0N0zmEt8GzQAamQtLnO_hYl1YcIEMO4KxeJeGn35kY3OeQGeVavSzroLlAYKdES0KAyGG728bBL-BVc5BL',
              //       ),
              //       _attendeeAvatar(
              //         'https://lh3.googleusercontent.com/aida-public/AB6AXuDgxxuTh-nwwb7GypbOu3TyMSVCrLvAQmMNOUTzvBAsIJXymQzIEhl9WcZSS1qYP3QAjpghH-2qnQDI4oeBM1jnVoHgWK3N3dO4T8z35vw7NVl-j5HPC5y5MSC5gmZNSB73Z9H7dOVGZUL57Ghux069druU0EgpH5ZT29faTGc8vPNOjTCtMBYBH1bklpwFubIOvdf-xGVRzGUn74BBY6qZps0wYrxdzMnkADVjglnFsqSyqIKeBhodJ4xF1J9vFhfQIawrORabk5jO',
              //       ),
              //     ],
              //   ),
              // ),
          
              // Instructions
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Text(
                  'Please bring your own water bottle, snacks, and wear appropriate hiking shoes. Meet at the trailhead parking lot 15 minutes before the start time.',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryTextColor,
                    height: 1.5,
                  ),
                ),
              ),
          
              // Join Event Button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B80EE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      // Handle join event action
                    },
                    child: const Text(
                      'Join Event',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, Color borderColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF60768a),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF111518),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _attendeeAvatar(String imageUrl) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 8),
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         CircleAvatar(
  //           radius: 22,
  //           backgroundColor: const Color(0xFFF0F2F5),
  //         ),
  //         CircleAvatar(
  //           radius: 18,
  //           backgroundImage: NetworkImage(imageUrl),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}