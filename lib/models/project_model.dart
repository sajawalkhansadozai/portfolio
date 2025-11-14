import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final String category;
  final List<String> techStack;
  final String? liveUrl;
  final String? githubUrl;
  final List<Color> gradientColors;

  ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.techStack,
    this.liveUrl,
    this.githubUrl,
    required this.gradientColors,
  });

  static List<ProjectModel> getProjects() {
    return [
      ProjectModel(
        title: 'Mirabella Evee Bikes',
        subtitle: 'Sales & Order Booking System',
        description:
            'A comprehensive e-commerce platform for electric bikes featuring product catalog with variant selection, lead-to-order flow, Firebase authentication (phone/email), Firestore for order management, and cloud storage for images. Includes admin panel for stock status, price updates, and order management with responsive UI and cached images.',
        category: 'E-Commerce Application',
        techStack: [
          'Flutter',
          'Firebase Auth',
          'Firestore',
          'Storage',
          'Provider',
        ],
        liveUrl: 'https://www.mirabellaevee.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFF2E3192), const Color(0xFF1E2272)],
      ),
      ProjectModel(
        title: 'Mirabella Complex Islmabad',
        subtitle: 'Inventory & Mini-POS System',
        description:
            'Advanced inventory management system with SKU management (add/edit), stock in/out tracking, purchase & sales logs. Features basic billing with cart, discounts, taxes, printable invoice layout, low-stock alerts, and CSV export for monthly reports.',
        category: 'Business Management',
        techStack: ['Flutter Web', 'Firebase', 'Cloud Functions', 'CSV Export'],
        liveUrl: 'https://www.mirabellacomplexislamabad.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
      ),
      ProjectModel(
        title: 'Mirabella eShifa Lab',
        subtitle: 'Test Booking & Diagnostics Platform',
        description:
            'Medical diagnostics platform with test catalog, pricing, time slot booking, patient profile management, order history, status tracking, and receipt PDF generation. Admin features include test CRUD operations, availability calendar, and promo code management.',
        category: 'Healthcare Application',
        techStack: ['Flutter', 'Firebase Auth', 'Firestore', 'PDF Generation'],
        liveUrl: 'https://mirabellaeshifa.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFF00BCD4), const Color(0xFF0097A7)],
      ),
      ProjectModel(
        title: 'Lawn Doctor',
        subtitle: 'Lawn Care Services Booking',
        description:
            'Service booking platform for landscaping and lawn care with dynamic pricing, add-ons, booking wizard with address selection, date/time picker, and order tracking. Features admin dashboard for schedule and crew assignment with push notifications.',
        category: 'Service Booking App',
        techStack: ['Flutter', 'Firebase', 'Google Maps', 'Push Notifications'],
        liveUrl: 'https://mylawndoctors.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFF4CAF50), const Color(0xFF388E3C)],
      ),
      ProjectModel(
        title: 'Lilium Towers',
        subtitle: 'Real Estate Marketing & Lead Capture',
        description:
            'Real estate marketing platform with project pages showcasing floorplans, amenities, galleries, and FAQs. Features lead capture forms with validation, CRM-ready export (CSV/Sheets), inquiry routing via email/Firestore, and WhatsApp integration.',
        category: 'Real Estate Web App',
        techStack: ['Flutter Web', 'Firebase', 'Responsive UI', 'SEO'],
        liveUrl: 'https://liliumtowers.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFFFF6B6B), const Color(0xFFEE5A6F)],
      ),
      ProjectModel(
        title: 'Mirabella Travel & Tours',
        subtitle: 'Travel Packages & Inquiries',
        description:
            'Travel agency platform with package listings (filters, search), detailed itinerary pages, inquiry/booking forms, payment placeholder, and email notifications. Admin panel for package CRUD, promo banners, and featured trips management.',
        category: 'Travel & Tourism',
        techStack: ['Flutter', 'Firebase', 'Email Integration', 'WhatsApp'],
        liveUrl: 'https://mirabellatravelandtours.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFF56CCF2), const Color(0xFF2F80ED)],
      ),
      ProjectModel(
        title: 'Hotel Mirabella Floresca',
        subtitle: 'Hotel Booking & Management System',
        description:
            'Comprehensive hotel management platform featuring room booking system, real-time availability calendar, guest profile management, and online reservation system. Includes admin dashboard for room management, pricing updates, booking status tracking, and guest communication.',
        category: 'Hospitality & Tourism',
        techStack: [
          'Flutter Web',
          'Firebase',
          'Booking System',
          'Payment Gateway',
        ],
        liveUrl: 'https://hotelmirabellafloresca.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFFFFA726), const Color(0xFFFF6F00)],
      ),
      ProjectModel(
        title: 'Mirabella Events',
        subtitle: 'Event Management & Booking Platform',
        description:
            'Full-featured event management platform for booking and organizing events, weddings, and corporate functions. Features event catalog, venue selection, package customization, real-time availability, booking management, and automated notifications. Admin panel for event CRUD, vendor management, and customer communication.',
        category: 'Event Management',
        techStack: [
          'Flutter Web',
          'Firebase',
          'Calendar Integration',
          'Notifications',
        ],
        liveUrl: 'https://mirabellaevents.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFFE91E63), const Color(0xFFC2185B)],
      ),
      ProjectModel(
        title: 'Rahiz Spa',
        subtitle: 'Spa & Wellness Booking Platform',
        description:
            'Elegant spa and wellness center booking platform featuring service catalog with detailed treatments, therapist profiles, appointment scheduling with time slots, package deals, and membership programs. Includes customer profile management, booking history, loyalty rewards, and admin dashboard for service management and staff scheduling.',
        category: 'Wellness & Beauty',
        techStack: [
          'Flutter Web',
          'Firebase',
          'Appointment System',
          'Payment Integration',
        ],
        liveUrl: 'https://www.rahizspa.com/',
        githubUrl: null,
        gradientColors: [const Color(0xFF9C27B0), const Color(0xFF7B1FA2)],
      ),
    ];
  }
}
