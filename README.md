# 🍽️ Online Food Inventory Management App 📦

## Introduction
This repository contains the source code for an Online Food Inventory Management Application. The application is built using Ruby on Rails framework and facilitates managing meals, ingredients, orders, stocks, and integrates with a third-party API for meal searching.

## LIVE SERVER
https://onlinefood-app.onrender.com/users/sign_in

## Controller Classes

### IngredientsController
The IngredientsController manages operations related to ingredients.

#### Actions:
1. `meal_ingredients`: Retrieves ingredients for a specific meal.
2. `add`: Displays a form to add ingredients to a meal.
3. `create`: Creates a new ingredient for a meal and updates the stock accordingly.

### MealsController
The MealsController manages operations related to meals.

#### Actions:
1. `add_meals_fromAPI`: Adds meals fetched from an external API.
2. `all_meals`: Retrieves all meals for the current user.
3. `meal_byletter`: Retrieves meals based on a specific letter.
4. `find_meal`: Finds meals based on search criteria.
5. `search_results`: Displays search results for meals.
6. `add_meal`: Displays a form to add a new meal.
7. `create`: Creates a new meal.
8. `edit`: Displays a form to edit a meal.
9. `destroy`: Deletes a meal along with its associated ingredients and order items.
10. `update`: Updates an existing meal.

### OrdersController
The OrdersController manages operations related to orders.

#### Actions:
1. `index`: Displays the order history for the current user.
2. `menu`: Displays the menu to place an order.
3. `create`: Creates a new order and calculates the total bill.

### StocksController
The StocksController manages operations related to ingredient stocks.

#### Actions:
1. `index`: Displays the list of ingredient stocks for the current user.
2. `edit`: Displays a form to edit the quantity of a specific ingredient stock.
3. `update`: Updates the quantity of an ingredient stock.

## Third-Party API Integration
The application integrates with a third-party API to search for meals.

### Mealdb Class
The Mealdb class interacts with the MealDB API to perform meal-related operations.

#### Methods:
1. `search_mealbyName(meal_name)`: Searches for meals by name.
2. `mealbyletter`: Retrieves meals based on a specific letter.

## Setup Instructions
To run the application locally, follow these steps:
1. Clone this repository to your local machine.
2. Install Ruby on Rails if not already installed.
3. Navigate to the project directory and run `bundle install` to install dependencies.
4. Run `rails db:migrate` to run migrations and set up the database.
5. Start the Rails server using `rails server`.
6. Access the application in your web browser at `http://localhost:3000`.



