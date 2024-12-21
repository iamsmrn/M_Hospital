import 'package:flutter/material.dart';

class MedicineListPage extends StatefulWidget {
  const MedicineListPage({super.key});

  @override
  State<MedicineListPage> createState() => _MedicineListPageState();
}

class _MedicineListPageState extends State<MedicineListPage> {
  final List<String> medicines = const [
    'Paracetomol',
    'Lignocaine with Adernaline(inj)'
    'Acetyl Salicylic Acid',
    'Pentazocin Lactate'
    'Chlorpeniramine Maleate',
    'Promethazine Hydrochloride',
    'predinisolone'
    'Charcoal ',
    'Snake Venom Antiserum',
    'Carbamezapine',
    'sodium Valproate',
    'Mebendazole',
    'Albendazole',
    'Benzathine Penicillin' ,
    'Ampicillin',
    'Cephalexin',
    'Griseofulvin',
    'Fluconazole',
    'Ferrous Sulfate',
    'Ferrus Fumarate'
    'Tranexamin acid',
    'Digoxin',
    'Amitriptyline',
    'Amlodipine',
    'Morphine',
    'prednisolone',
    'Lamivudine ',
    'Dolutegravir',
    'Teneligliptin',
    'Montelukast',
    'Amikacin',
    'Delamanid'
    'Tenecteplase',
    'Dabigatram',
    'Ibuprofen',
    'Aspirin',
    'Diclofenac',
    'Tramadol',
    'Azithromycin'
  ];

  String searchQuery = '';

  List<String> get filteredMedicines => medicines
      .where((medicine) =>
      medicine.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00B894)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'List Of All Medicines',
          style: TextStyle(
            color: Color(0xFF00B894),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search medicines...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00B894)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF00B894)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF00B894)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredMedicines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    '${index + 1}.${filteredMedicines[index]}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}