import os
import yaml

def create_transactions_func(path_of_data, path_of_labels):
    # Create food_dict by using data.yaml
    with open(path_of_data, "r", encoding="utf-8") as file: # Path of data.yaml
        data = yaml.safe_load(file)
    names = data["names"] # Name of the variable which contains the names of the foods in data.yaml
    food_dict = {i: name for i, name in enumerate(names)}

    # Path of labels directory
    labels_dir = path_of_labels

    # List of transactions
    all_transactions = []
    food_counter = 0

    for filename in os.listdir(labels_dir):
        food_counter += 1
        if filename.endswith(".txt"):  # Process only .txt files (if there are any other files)
            file_path = os.path.join(labels_dir, filename)
            with open(file_path, "r") as file:
                lines = file.readlines() # Read the lines because every line has a ID for a food
                current_transaction = [] # Current transaction in this lable file
                for line in lines:
                    id_ = int(line.split()[0])  # Read the first element of the line because it's ID
                    if id_ in food_dict: 
                        current_transaction.append(food_dict[id_]) # Add the food name to the current transaction if it's in the food_dict
                if current_transaction:
                    all_transactions.append(current_transaction) # Add the current transaction to the list of all transactions if the label file is not empty

    return all_transactions

# Print the transactions for testing
'''
for t in transactions:
    print(t)
'''