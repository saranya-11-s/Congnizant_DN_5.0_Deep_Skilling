package com.cts.search;

public class Main {

    public static void main(String[] args) {

        Product[] products = {

            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Mobile Phone", "Electronics"),
            new Product(103, "Headphones", "Accessories"),
            new Product(104, "Smart Watch", "Wearables"),
            new Product(105, "Keyboard", "Accessories"),
            new Product(106, "Mouse", "Accessories")
        };

        int searchId = 104;

        System.out.println("===== LINEAR SEARCH =====");

        Product linearResult =
                SearchOperations.linearSearch(products, searchId);

        if (linearResult != null) {
            System.out.println("Product Found:");
            System.out.println(linearResult);
        }
        else {
            System.out.println("Product Not Found");
        }

        System.out.println();

        System.out.println("===== BINARY SEARCH =====");

        Product binaryResult =
                SearchOperations.binarySearch(products, searchId);

        if (binaryResult != null) {
            System.out.println("Product Found:");
            System.out.println(binaryResult);
        }
        else {
            System.out.println("Product Not Found");
        }
    }
}