

class CardProvider {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final double hourlyRate;
  final bool isVerified;

  CardProvider({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.hourlyRate,
    required this.isVerified,
  });
}


List<CardProvider> getAllProviders() {
  return [
    CardProvider(
      id: '1',
      name: 'John Smith',
      imageUrl: 'https://i.pravatar.cc/150?img=12',
      rating: 4.8,
      hourlyRate: 45.0,
      isVerified: true,
    ),
    CardProvider(
      id: '2',
      name: 'Emma Johnson',
      imageUrl: 'https://i.pravatar.cc/150?img=45',
      rating: 4.9,
      hourlyRate: 50.0,
      isVerified: true,
    ),
    CardProvider(
      id: '3',
      name: 'Michael Brown',
      imageUrl: 'https://i.pravatar.cc/150?img=33',
      rating: 4.5,
      hourlyRate: 40.0,
      isVerified: false,
    ),
    CardProvider(
      id: '4',
      name: 'Sarah Davis',
      imageUrl: 'https://i.pravatar.cc/150?img=47',
      rating: 4.7,
      hourlyRate: 48.0,
      isVerified: true,
    ),
    CardProvider(
      id: '5',
      name: 'David Wilson',
      imageUrl: 'https://i.pravatar.cc/150?img=15',
      rating: 4.6,
      hourlyRate: 42.0,
      isVerified: true,
    ),
    CardProvider(
      id: '6',
      name: 'Lisa Anderson',
      imageUrl: 'https://i.pravatar.cc/150?img=38',
      rating: 4.4,
      hourlyRate: 38.0,
      isVerified: false,
    ),
    CardProvider(
      id: '7',
      name: 'James Martinez',
      imageUrl: 'https://i.pravatar.cc/150?img=52',
      rating: 4.9,
      hourlyRate: 55.0,
      isVerified: true,
    ),
    CardProvider(
      id: '8',
      name: 'Emily Taylor',
      imageUrl: 'https://i.pravatar.cc/150?img=25',
      rating: 4.3,
      hourlyRate: 35.0,
      isVerified: false,
    ),
    CardProvider(
      id: '9',
      name: 'Robert Thomas',
      imageUrl: 'https://i.pravatar.cc/150?img=60',
      rating: 4.8,
      hourlyRate: 47.0,
      isVerified: true,
    ),
    CardProvider(
      id: '10',
      name: 'Jennifer Lee',
      imageUrl: 'https://i.pravatar.cc/150?img=28',
      rating: 4.7,
      hourlyRate: 46.0,
      isVerified: true,
    ),
  ];
}