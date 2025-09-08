#for_each

#toset & tomap --> map requires all of the elements to be of the same type, mixed-typed elements will be converted.

# Map is supported for "for_each" type of outputs




#Why use to_set with for_each?
Ensures uniform type → converts list items into a consistent type.
Removes duplicates → only unique values remain.
Prevents errors → for_each needs unique keys, so using a set avoids conflicts.
👉 In short: to_set makes lists safe and clean for looping with for_each.


#Why use tomap in Terraform?

Guarantees map structure → ensures data is in key-value format.

Converts lists/tuples → into maps for easier processing.

Useful in modules/resources → many configs expect maps.

Improves readability & consistency → makes data handling cleaner.

👉 In short: tomap is used when you need structured key-value pairs instead of raw lists.

