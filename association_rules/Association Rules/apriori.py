from mlxtend.frequent_patterns import apriori, association_rules # We will use this library for apriori algorithm
import pandas as pd
import create_transactions as ct # The Python file which contains the function to create transactions

transactions = ct.create_transactions_func("D:\Python Projects\Veri Madenciliği\data.yaml", "D:\Python Projects\Veri Madenciliği\labels")  # Path of data.yaml and labels directory

# The variable which contains all the food names in the transactions
all_items = set(item for transaction in transactions for item in transaction) 

# Convert data to a "One-Hot Encoding" format for the Apriori algorithm which means that the data is in a binary format (Pirinc Pilavi: 1, Kuru Fasulye: 1, Ayran: 0, ...)
df = pd.DataFrame([{item: (item in transaction) for item in all_items} for transaction in transactions])

# Find the frequent itemsets with a minimum support of 0.035 (3.5%). If we increase the minimum support, we will get fewer itemsets.
frequent_itemsets = apriori(df, min_support=0.035, use_colnames=True)

frequent_itemsets = frequent_itemsets.sort_values(by="support", ascending=True)

# Create association rules with a minimum confidence of 0.4 (40%). If we increase the minimum confidence, we will get fewer rules.
min_confidence = 0.4
num_itemsets = len(frequent_itemsets)
rules = association_rules(frequent_itemsets, metric="confidence", min_threshold = min_confidence, num_itemsets = num_itemsets) 

# The columns we want to see in the output
selected_columns = [
    'antecedents',
    'consequents',
    'antecedent support',
    'consequent support',
    'support',
    'confidence'
]

# Create the combinations of 2, 3, and 4 items
pair_combinations = rules[rules['antecedents'].apply(len) == 1] # Number of antecedents is 1
triple_combinations = rules[rules['antecedents'].apply(len) == 2]
quad_combinations = rules[rules['antecedents'].apply(len) == 3]

# Filter the columns of combinations
pair_combinations_filtered = pair_combinations[selected_columns]
triple_combinations_filtered = triple_combinations[selected_columns]
quad_combinations_filtered = quad_combinations[selected_columns]

print("\nMost Frequent Pair Combinations:")
print(pair_combinations_filtered)

print("\nMost Frequent Triple Combinations:")
print(triple_combinations_filtered)

print("\nMost Frequent Quad Combinations:")
print(quad_combinations_filtered)