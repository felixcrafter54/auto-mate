/// Static vehicle database for makes and models.
/// Used as primary source (NHTSA only covers US market).
class VehicleData {
  static const List<String> makes = [
    'Abarth', 'Acura', 'Alfa Romeo', 'Aston Martin', 'Audi',
    'Bentley', 'BMW', 'Bugatti', 'Buick',
    'Cadillac', 'Chevrolet', 'Chrysler', 'Citroën',
    'Dacia', 'Daewoo', 'Daihatsu', 'Dodge', 'DS',
    'Ferrari', 'Fiat', 'Ford',
    'Genesis', 'GMC',
    'Honda', 'Hyundai',
    'Infiniti', 'Isuzu',
    'Jaguar', 'Jeep',
    'Kia',
    'Lada', 'Lamborghini', 'Land Rover', 'Lexus', 'Lincoln', 'Lotus',
    'Maserati', 'Mazda', 'McLaren', 'Mercedes-Benz', 'MINI', 'Mitsubishi',
    'Nissan',
    'Opel',
    'Peugeot', 'Pontiac', 'Porsche',
    'RAM', 'Renault', 'Rolls-Royce',
    'SEAT', 'Škoda', 'Smart', 'SsangYong', 'Subaru', 'Suzuki',
    'Tesla', 'Toyota',
    'Vauxhall', 'Volkswagen', 'Volvo',
  ];

  static const Map<String, List<String>> models = {
    'Abarth': ['500', '595', '695'],
    'Acura': ['ILX', 'MDX', 'RDX', 'TLX'],
    'Alfa Romeo': ['147', '156', '159', '166', 'Giulia', 'Giulietta', 'MiTo', 'Stelvio', 'Tonale'],
    'Aston Martin': ['DB11', 'DBS', 'DBX', 'Vantage'],
    'Audi': ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'e-tron', 'Q2', 'Q3', 'Q4 e-tron', 'Q5', 'Q7', 'Q8', 'R8', 'RS3', 'RS4', 'RS5', 'RS6', 'RS7', 'S3', 'S4', 'S5', 'S6', 'SQ5', 'TT'],
    'BMW': ['1er', '2er', '3er', '4er', '5er', '6er', '7er', '8er', 'iX', 'iX1', 'iX3', 'M2', 'M3', 'M4', 'M5', 'M6', 'M8', 'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'Z4'],
    'Chevrolet': ['Camaro', 'Colorado', 'Corvette', 'Cruze', 'Equinox', 'Malibu', 'Silverado', 'Suburban', 'Tahoe', 'Trax'],
    'Citroën': ['Berlingo', 'C1', 'C2', 'C3', 'C3 Aircross', 'C4', 'C4 Cactus', 'C5', 'C5 Aircross', 'C5 X', 'DS3', 'Jumpy', 'Picasso'],
    'Dacia': ['Duster', 'Logan', 'Sandero', 'Spring', 'Jogger'],
    'Fiat': ['124 Spider', '500', '500L', '500X', 'Bravo', 'Doblo', 'Grande Punto', 'Panda', 'Punto', 'Tipo'],
    'Ford': ['B-Max', 'C-Max', 'EcoSport', 'Edge', 'Explorer', 'F-150', 'Fiesta', 'Focus', 'Galaxy', 'Ka', 'Kuga', 'Mondeo', 'Mustang', 'Puma', 'Ranger', 'S-Max', 'Transit'],
    'Honda': ['Accord', 'Civic', 'CR-V', 'CR-Z', 'e', 'HR-V', 'Jazz', 'Legend', 'NSX', 'Pilot'],
    'Hyundai': ['Bayon', 'Elantra', 'Genesis', 'Getz', 'i10', 'i20', 'i30', 'i40', 'ioniq', 'IONIQ 5', 'IONIQ 6', 'ix20', 'ix35', 'Kona', 'Santa Fe', 'Sonata', 'Staria', 'Terracan', 'Tucson'],
    'Jaguar': ['E-Pace', 'F-Pace', 'F-Type', 'I-Pace', 'S-Type', 'XE', 'XF', 'XJ'],
    'Jeep': ['Cherokee', 'Compass', 'Grand Cherokee', 'Renegade', 'Wrangler'],
    'Kia': ['Carens', 'Ceed', 'EV6', 'Niro', 'Optima', 'Picanto', 'ProCeed', 'Rio', 'Sorento', 'Soul', 'Sportage', 'Stinger', 'Stonic', 'Venga', 'XCeed'],
    'Land Rover': ['Defender', 'Discovery', 'Discovery Sport', 'Freelander', 'Range Rover', 'Range Rover Evoque', 'Range Rover Sport', 'Range Rover Velar'],
    'Lexus': ['CT', 'ES', 'GS', 'GX', 'IS', 'LC', 'LS', 'LX', 'NX', 'RC', 'RX', 'UX'],
    'Mazda': ['2', '3', '5', '6', 'CX-3', 'CX-30', 'CX-5', 'CX-7', 'CX-9', 'MX-5', 'MX-30', 'RX-8'],
    'Mercedes-Benz': ['A-Klasse', 'B-Klasse', 'C-Klasse', 'CLA', 'CLS', 'E-Klasse', 'EQA', 'EQB', 'EQC', 'EQE', 'EQS', 'G-Klasse', 'GLA', 'GLB', 'GLC', 'GLE', 'GLS', 'ML', 'S-Klasse', 'SL', 'SLK', 'Sprinter', 'V-Klasse'],
    'MINI': ['Cabrio', 'Clubman', 'Cooper', 'Cooper S', 'Countryman', 'Paceman'],
    'Mitsubishi': ['ASX', 'Eclipse Cross', 'Galant', 'L200', 'Lancer', 'Outlander', 'Pajero', 'Space Star'],
    'Nissan': ['350Z', '370Z', 'Ariya', 'Juke', 'Leaf', 'Micra', 'Murano', 'Navara', 'Note', 'Pathfinder', 'Patrol', 'Pulsar', 'Qashqai', 'X-Trail'],
    'Opel': ['Adam', 'Agila', 'Antara', 'Astra', 'Cascada', 'Corsa', 'Crossland', 'Frontera', 'Grandland', 'Insignia', 'Meriva', 'Mokka', 'Omega', 'Vectra', 'Vivaro', 'Zafira'],
    'Peugeot': ['108', '2008', '208', '3008', '301', '308', '4007', '4008', '408', '5008', '508', 'Boxer', 'Expert', 'Partner', 'RCZ'],
    'Porsche': ['718', '911', 'Boxster', 'Cayenne', 'Cayman', 'Macan', 'Panamera', 'Taycan'],
    'Renault': ['Arkana', 'Captur', 'Clio', 'Espace', 'Fluence', 'Grand Scénic', 'Kadjar', 'Kangoo', 'Koleos', 'Laguna', 'Master', 'Megane', 'Modus', 'Scénic', 'Talisman', 'Traffic', 'Twingo', 'Zoe'],
    'SEAT': ['Alhambra', 'Altea', 'Arona', 'Ateca', 'Cordoba', 'Ibiza', 'Leon', 'Mii', 'Tarraco', 'Toledo'],
    'Škoda': ['Citigo', 'Enyaq', 'Fabia', 'Kamiq', 'Karoq', 'Kodiaq', 'Octavia', 'Rapid', 'Roomster', 'Scala', 'Superb', 'Yeti'],
    'Subaru': ['BRZ', 'Forester', 'Impreza', 'Legacy', 'Outback', 'Solterra', 'WRX', 'XV'],
    'Suzuki': ['Alto', 'Baleno', 'Celerio', 'Grand Vitara', 'Ignis', 'Jimny', 'Kizashi', 'S-Cross', 'Splash', 'Swift', 'SX4', 'Vitara'],
    'Tesla': ['Cybertruck', 'Model 3', 'Model S', 'Model X', 'Model Y'],
    'Toyota': ['Auris', 'Avensis', 'Aygo', 'Camry', 'C-HR', 'Corolla', 'GR86', 'GR Yaris', 'Hilux', 'Land Cruiser', 'Prius', 'ProAce', 'RAV4', 'Supra', 'Urban Cruiser', 'Yaris'],
    'Vauxhall': ['Astra', 'Corsa', 'Insignia', 'Mokka', 'Vivaro', 'Zafira'],
    'Volkswagen': ['Amarok', 'Arteon', 'Caddy', 'California', 'Caravelle', 'CC', 'Golf', 'ID.3', 'ID.4', 'ID.5', 'Jetta', 'Passat', 'Phaeton', 'Polo', 'Scirocco', 'Sharan', 'T-Cross', 'T-Roc', 'Taigo', 'Tiguan', 'Touareg', 'Touran', 'Transporter', 'Up!'],
    'Volvo': ['C30', 'C40', 'S40', 'S60', 'S80', 'S90', 'V40', 'V50', 'V60', 'V70', 'V90', 'XC40', 'XC60', 'XC70', 'XC90'],
  };

  static List<String> getModels(String make) {
    return models[make] ?? [];
  }

  static List<String> searchMakes(String query) {
    if (query.isEmpty) return makes;
    final q = query.toLowerCase();
    return makes.where((m) => m.toLowerCase().contains(q)).toList();
  }

  static List<String> searchModels(String make, String query) {
    final list = getModels(make);
    if (query.isEmpty) return list;
    final q = query.toLowerCase();
    return list.where((m) => m.toLowerCase().contains(q)).toList();
  }
}
