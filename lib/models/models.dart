// Mock data models for Benefits Industries

class ProductCategory {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int productCount;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.productCount,
  });
}

class Product {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final double? originalPrice;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final bool isNew;
  final bool isFeatured;
  final String material;
  final int moq; // Minimum order quantity for B2B

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.sizes,
    required this.colors,
    required this.rating,
    required this.reviewCount,
    this.inStock = true,
    this.isNew = false,
    this.isFeatured = false,
    required this.material,
    this.moq = 50,
  });
}

class Testimonial {
  final String id;
  final String name;
  final String company;
  final String country;
  final String message;
  final double rating;

  const Testimonial({
    required this.id,
    required this.name,
    required this.company,
    required this.country,
    required this.message,
    required this.rating,
  });
}

class CompanyStat {
  final String value;
  final String label;
  final String icon;

  const CompanyStat({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class TeamMember {
  final String name;
  final String role;
  final String bio;

  const TeamMember({
    required this.name,
    required this.role,
    required this.bio,
  });
}

class ManufacturingStep {
  final String title;
  final String description;
  final String icon;
  final int stepNumber;

  const ManufacturingStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.stepNumber,
  });
}

class CartItem {
  final Product product;
  String selectedSize;
  String selectedColor;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });

  double get total => product.price * quantity;
}

class Review {
  final String reviewer;
  final double rating;
  final String comment;
  final String date;

  const Review({
    required this.reviewer,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

// ─────────────── Mock Data ───────────────

final List<ProductCategory> mockCategories = [
  const ProductCategory(
    id: 'mens',
    name: "Men's Wear",
    description: 'Premium formal & casual wear for men',
    icon: '👔',
    productCount: 48,
  ),
  const ProductCategory(
    id: 'womens',
    name: "Women's Wear",
    description: 'Elegant fashion-forward apparel for women',
    icon: '👗',
    productCount: 62,
  ),
  const ProductCategory(
    id: 'sportswear',
    name: 'Sportswear',
    description: 'High-performance athletic and sports clothing',
    icon: '🏃',
    productCount: 35,
  ),
  const ProductCategory(
    id: 'hoodies',
    name: 'Hoodies',
    description: 'Premium fleece & cotton hoodies',
    icon: '🧥',
    productCount: 27,
  ),
  const ProductCategory(
    id: 'tshirts',
    name: 'T-Shirts',
    description: 'Custom printed & plain premium tees',
    icon: '👕',
    productCount: 84,
  ),
  const ProductCategory(
    id: 'denim',
    name: 'Denim',
    description: 'Quality denim jeans, jackets & skirts',
    icon: '🧖',
    productCount: 41,
  ),
  const ProductCategory(
    id: 'uniforms',
    name: 'Uniforms',
    description: 'Corporate, school & industrial uniforms',
    icon: '🦺',
    productCount: 23,
  ),
  const ProductCategory(
    id: 'export',
    name: 'Export Quality',
    description: 'International standard export garments',
    icon: '✈️',
    productCount: 56,
  ),
];

final List<Product> mockProducts = [
  const Product(
    id: 'p1',
    name: 'Classic Oxford Shirt',
    categoryId: 'mens',
    price: 2499,
    originalPrice: 3200,
    description:
        'A timeless Oxford shirt crafted from 100% premium Egyptian cotton. Features a button-down collar, chest pocket, and a tailored fit that works from boardroom to casual outings.',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['White', 'Sky Blue', 'Navy', 'Grey'],
    rating: 4.8,
    reviewCount: 124,
    isFeatured: true,
    material: '100% Egyptian Cotton',
    moq: 100,
  ),
  const Product(
    id: 'p2',
    name: 'Elite Polo Shirt',
    categoryId: 'mens',
    price: 1899,
    description:
        'Performance polo shirt made from moisture-wicking piqué fabric. Ideal for both sports and smart-casual settings.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'White', 'Red', 'Navy', 'Forest Green'],
    rating: 4.7,
    reviewCount: 89,
    isFeatured: true,
    material: 'Piqué Cotton Blend',
    moq: 50,
  ),
  const Product(
    id: 'p3',
    name: 'Premium Floral Kurta',
    categoryId: 'womens',
    price: 3200,
    originalPrice: 4000,
    description:
        'Handcrafted floral kurta with intricate embroidery. Made from soft lawn fabric for all-day comfort and elegance.',
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    colors: ['Rose', 'Ivory', 'Sage', 'Dusty Blue'],
    rating: 4.9,
    reviewCount: 203,
    isNew: true,
    isFeatured: true,
    material: 'Pure Lawn Cotton',
    moq: 75,
  ),
  const Product(
    id: 'p4',
    name: 'Pro Training Hoodie',
    categoryId: 'hoodies',
    price: 3500,
    description:
        'Ultra-soft 320 GSM fleece hoodie with kangaroo pocket and ribbed cuffs. Perfect for training or streetwear.',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['Black', 'Charcoal', 'Olive', 'Burgundy'],
    rating: 4.8,
    reviewCount: 156,
    isFeatured: true,
    material: '320 GSM Cotton Fleece',
    moq: 50,
  ),
  const Product(
    id: 'p5',
    name: 'Graphic Print Tee',
    categoryId: 'tshirts',
    price: 1200,
    description:
        '180 GSM ring-spun cotton t-shirt with custom screen printing. Vibrant colors that last wash after wash.',
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    colors: ['White', 'Black', 'Grey', 'Custom'],
    rating: 4.6,
    reviewCount: 312,
    isNew: true,
    material: '180 GSM Ring-Spun Cotton',
    moq: 100,
  ),
  const Product(
    id: 'p6',
    name: 'Slim Fit Denim Jeans',
    categoryId: 'denim',
    price: 4200,
    originalPrice: 5000,
    description:
        'Premium 12oz selvedge denim with a modern slim fit. Features a 5-pocket design with reinforced stitching for durability.',
    sizes: ['28', '30', '32', '34', '36', '38'],
    colors: ['Indigo', 'Washed Blue', 'Black', 'Grey'],
    rating: 4.7,
    reviewCount: 178,
    isFeatured: true,
    material: '12oz Selvedge Denim',
    moq: 50,
  ),
  const Product(
    id: 'p7',
    name: 'Corporate Uniform Set',
    categoryId: 'uniforms',
    price: 8500,
    description:
        'Complete corporate uniform package including shirt, trousers, and tie. Available with custom logo embroidery.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy/White', 'Grey/Black', 'Custom'],
    rating: 4.9,
    reviewCount: 67,
    isFeatured: true,
    material: 'TR Fabric Blend',
    moq: 25,
  ),
  const Product(
    id: 'p8',
    name: 'Export Track Suit',
    categoryId: 'sportswear',
    price: 5800,
    description:
        'International standard track suit with moisture management technology. Meets EU export quality standards.',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['Black/Gold', 'Navy/White', 'Red/White'],
    rating: 4.8,
    reviewCount: 94,
    isNew: true,
    isFeatured: true,
    material: 'Polyester Moisture-Wicking',
    moq: 50,
  ),
];

final List<Testimonial> mockTestimonials = [
  const Testimonial(
    id: 't1',
    name: 'James Richardson',
    company: 'UK Fashion Imports Ltd',
    country: '🇬🇧 United Kingdom',
    message:
        'Benefits Industries delivers exceptional quality that meets our strict UK retail standards. The fabric quality, stitching consistency, and on-time delivery have made them our primary supplier for 3 years running.',
    rating: 5.0,
  ),
  const Testimonial(
    id: 't2',
    name: 'Sophie Laurent',
    company: 'Mode Parisienne',
    country: '🇫🇷 France',
    message:
        'The attention to detail in their custom embroidery and print work is outstanding. Our boutique customers love the quality and we appreciate their professional approach to bulk orders.',
    rating: 4.9,
  ),
  const Testimonial(
    id: 't3',
    name: 'Ahmed Al-Rashidi',
    company: 'Gulf Textile Co.',
    country: '🇦🇪 UAE',
    message:
        'We source all our sportswear and corporate uniforms from Benefits Industries. Competitive pricing, excellent MOQ flexibility, and top-tier quality. Highly recommended for B2B buyers.',
    rating: 5.0,
  ),
  const Testimonial(
    id: 't4',
    name: 'Marcus Thompson',
    company: 'Urban Style USA',
    country: '🇺🇸 United States',
    message:
        'Their graphic tees and hoodies meet our American market requirements perfectly. The custom branding options and fast turnaround times have helped us scale our business significantly.',
    rating: 4.8,
  ),
];

final List<CompanyStat> mockStats = [
  const CompanyStat(value: '500+', label: 'Global Clients', icon: '🌍'),
  const CompanyStat(value: '45+', label: 'Countries Exported', icon: '✈️'),
  const CompanyStat(value: '2M+', label: 'Garments / Year', icon: '👕'),
  const CompanyStat(value: '18+', label: 'Years Experience', icon: '🏆'),
];

final List<TeamMember> mockTeam = [
  const TeamMember(
    name: 'Tariq Mahmood',
    role: 'Chief Executive Officer',
    bio: '20+ years in textile manufacturing. Pioneered the company\'s international expansion strategy.',
  ),
  const TeamMember(
    name: 'Sana Iqbal',
    role: 'Head of Design',
    bio: 'Award-winning fashion designer with expertise in contemporary and traditional apparel.',
  ),
  const TeamMember(
    name: 'Usman Aslam',
    role: 'Production Director',
    bio: 'Oversees 3 state-of-the-art manufacturing facilities with ISO-certified processes.',
  ),
  const TeamMember(
    name: 'Ayesha Raza',
    role: 'Export Manager',
    bio: 'Manages relationships with 500+ international buyers across 45 countries.',
  ),
];

final List<ManufacturingStep> mockManufacturingSteps = [
  const ManufacturingStep(
    stepNumber: 1,
    title: 'Fabric Sourcing',
    description:
        'We source premium fabrics directly from certified mills across Pakistan, India, and Turkey. Every batch undergoes rigorous quality testing for GSM, colorfastness, and tensile strength.',
    icon: '🧵',
  ),
  const ManufacturingStep(
    stepNumber: 2,
    title: 'Pattern & Cutting',
    description:
        'Computer-aided design (CAD) systems ensure precision pattern making. Our automated cutting machines guarantee zero material wastage and perfect size consistency across bulk orders.',
    icon: '✂️',
  ),
  const ManufacturingStep(
    stepNumber: 3,
    title: 'Stitching & Assembly',
    description:
        'Skilled artisans operate 1,200+ industrial sewing machines across our facilities. Each garment passes through multiple quality checkpoints during assembly.',
    icon: '🪡',
  ),
  const ManufacturingStep(
    stepNumber: 4,
    title: 'Printing & Embroidery',
    description:
        'State-of-the-art DTG printing, screen printing, and 32-head computerized embroidery machines produce vibrant, lasting designs that meet international wash-fastness standards.',
    icon: '🎨',
  ),
  const ManufacturingStep(
    stepNumber: 5,
    title: 'Quality Control',
    description:
        'Every garment is inspected against AQL 2.5 standards. Our in-house lab tests for shrinkage, color bleeding, and dimensional accuracy before approving for shipment.',
    icon: '🔍',
  ),
  const ManufacturingStep(
    stepNumber: 6,
    title: 'Packaging & Export',
    description:
        'Custom branded packaging options available. We handle all export documentation, compliance certifications, and can arrange DDP/FOB shipping to 45+ countries worldwide.',
    icon: '📦',
  ),
];

final List<Review> mockReviews = [
  const Review(
    reviewer: 'Ahmed K.',
    rating: 5.0,
    comment: 'Excellent quality! The fabric is exactly as described. Will order again.',
    date: 'March 2024',
  ),
  const Review(
    reviewer: 'Sarah M.',
    rating: 4.5,
    comment: 'Great fit and very premium feel. Delivery was quick too.',
    date: 'February 2024',
  ),
  const Review(
    reviewer: 'Jake T.',
    rating: 5.0,
    comment: 'Perfect for our uniform requirements. The embroidery is superb.',
    date: 'January 2024',
  ),
];
