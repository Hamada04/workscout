import 'package:flutter/material.dart';
import 'package:workscout/data/model/offer_model.dart';
import 'package:workscout/services/api_client.dart';
import 'package:workscout/view/screen/home/offerSuccessPage.dart';

class OfferLetterPage extends StatefulWidget {
  final String offerId;
  const OfferLetterPage({super.key, required this.offerId});

  @override
  State<OfferLetterPage> createState() => _OfferLetterPageState();
}

class _OfferLetterPageState extends State<OfferLetterPage> {
  OfferLetterModel? _offer;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchOffer();
  }

  Future<void> _fetchOffer() async {
    try {
      final response = await ApiClient.get('/offers/${widget.offerId}');
      setState(() {
        _offer = OfferLetterModel.fromJson(response as Map<String, dynamic>);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF334E58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Offer Letter", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text("Failed to load offer.\n$_error", textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)))
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    final o = _offer!;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Congratulations, Your Offer as a ${o.position}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(
            o.message.isNotEmpty ? o.message : "A warm message welcoming the applicant to the company.",
            style: const TextStyle(color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 30),
          _buildSectionTitle("Offer Summary"),
          _buildInfoRow("Position:", o.position),
          _buildInfoRow("Start Date:", o.startDate),
          _buildInfoRow("Salary:", o.salary),
          _buildInfoRow("Department:", o.department.isNotEmpty ? o.department : "N/A"),
          _buildInfoRow("Status:", o.status),
          _buildInfoRow("Expires:", o.expiresAt),
          const SizedBox(height: 25),
          _buildSectionTitle("Job Responsibilities"),
          const Text(
            "A brief overview of key responsibilities, such as designing user interfaces, creating wireframes, and collaborating with cross-functional teams.",
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle("Benefits"),
          const Text(
            "List of benefits, including health insurance, paid time off, retirement plans, and any other perks.",
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle("Terms and Conditions"),
          const Text(
            "List of benefits, including health insurance, paid time off, retirement plans, and any other perks.",
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: const BorderSide(color: Color(0xFF334E58)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Decline Offer", style: TextStyle(color: Color(0xFF334E58))),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF334E58),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OfferSuccessPage()),
                    );
                  },
                  child: const Text("Accept Offer", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label ", style: const TextStyle(color: Colors.black, fontSize: 13)),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.grey, fontSize: 13))),
        ],
      ),
    );
  }
}
