import 'package:flutter/material.dart';

void main() {
  runApp(const EthioMarketApp());
}

class EthioMarketApp extends StatelessWidget {
  const EthioMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ethio Market',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> categories = [
    'All',
    'Electronics',
    'Clothes',
    'Home',
    'Vehicles',
    'Tools',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Samsung Phone',
      'price': '25,000 ETB',
      'category': 'Electronics',
      'icon': Icons.phone_android,
    },
    {
      'name': 'Car Engine Oil',
      'price': '1,500 ETB',
      'category': 'Vehicles',
      'icon': Icons.oil_barrel,
    },
    {
      'name': 'Power Drill',
      'price': '4,500 ETB',
      'category': 'Tools',
      'icon': Icons.handyman,
    },
    {
      'name': 'Men Shirt',
      'price': '1,200 ETB',
      'category': 'Clothes',
      'icon': Icons.checkroom,
    },
  ];

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ethio Market',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),

      body: selectedIndex == 0
          ? buildHome()
          : selectedIndex == 1
              ? buildCategories()
              : buildProfile(),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddProductDialog,
        icon: const Icon(Icons.add),
        label: const Text('Sell Product'),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildHome() {
    final filteredProducts = selectedCategory == 'All'
        ? products
        : products
            .where((product) => product['category'] == selectedCategory)
            .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Ethio Market 🇪🇹',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Buy and sell products easily in Ethiopia.',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Popular Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final product = filteredProducts[index];

              return Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    showProductDetails(product);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          product['icon'],
                          size: 55,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['price'],
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildCategories() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length - 1,
      itemBuilder: (context, index) {
        final category = categories[index + 1];

        return Card(
          child: ListTile(
            leading: const Icon(
              Icons.category,
              color: Colors.green,
            ),
            title: Text(category),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              setState(() {
                selectedCategory = category;
                selectedIndex = 0;
              });
            },
          ),
        );
      },
    );
  }

  Widget buildProfile() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'My Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('Buyer & Seller'),
        ],
      ),
    );
  }

  void showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                product['icon'],
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 15),
              Text(
                product['price'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text('Category: ${product['category']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product added to cart'),
                  ),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        );
      },
    );
  }

  void showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sell a Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Product name',
                ),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price (ETB)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  setState(() {
                    products.add({
                      'name': nameController.text,
                      'price': '${priceController.text} ETB',
                      'category': 'Tools',
                      'icon': Icons.shopping_bag,
                    });
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product added successfully'),
                    ),
                  );
                }
              },
              child: const Text('Add Product'),
            ),
          ],
        );
      },
    );
  }
}
