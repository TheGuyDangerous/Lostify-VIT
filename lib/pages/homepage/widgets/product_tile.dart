import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/pages/homepage/models/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  void foundItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Found Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you found this item ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item marked as found'), //Adil
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item not marked as found'), //Adil
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  String get image => product.image;

  @override
  Widget build(BuildContext context) {
    double containerWidth =
        MediaQuery.of(context).size.width * 0.67; // 80% of screen width

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(25),
      width: containerWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(25),
              child: Image.network(
                image,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            product.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              product.description,
              // Adjust maxLines and overflow properties as needed
              maxLines:
                  1, // Adjust the number of lines before it starts scrolling
              overflow: TextOverflow
                  .ellipsis, // Overflow style when text exceeds maxLines
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => foundItem(context),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(8.0), // Adjust padding as needed
                  child: Text(
                    'Found it ?',
                    style: TextStyle(
                      color: AppColors
                          .inversePrimary, // Set your desired text color
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
