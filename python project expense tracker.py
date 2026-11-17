#!/usr/bin/env python
# coding: utf-8

# In[1]:


from datetime import datetime
import json

class Expense:
    """
    Represents an individual expense item.
    """
    def __init__(self, amount, category, description, date = None):
        self.amount = amount
        self.category = category
        self.description = description
        self.date = date if date else datetime.now().strftime("%y-%m-%d")
    def to_dict(self):
        """
        Converts the expense object into a dictionary for JSON storage.
        """
        return {
            "amount" : self.amount,
            "category" : self.category,
            "description" : self.description,
            "date" : self.date,
        }
class ExpenseTracker:
    """Manages all expenses and handles robust file operations with error handling."""
    def __init__(self, filename="expenses.json"):
        self.filename = filename
        self.expenses = []
        self.load_expenses()

    def add_expense(self, amount_str, category, description, date_str = None):
        try:
            # 1. Amount Validaton
            amount = float(amount_str)
            if amount <= 0:
                raise ValueError("Amount cannot be zero or negative!")

            # 2. Category Validaton
            category = category.strip()
            if not category:
                raise ValueError("Category cannot be empty!")

            # 3. Date Validaton(if custom date is provided)
            expense_date = None
            if date_str:
                parsed_date = datetime.strptime(date_str.strip(), "%Y-%m-%d")
                expense_date = parsed_date.strftime("%Y-%m-%d")

            # Create expense object and add to list
            expense = Expense(amount, category, description, expense_date)
            self.expenses.append(expense)
            self.save_expenses()
            print("\n Expense successfully added and saved!")
            return True

        except ValueError as err:
            print(f"\n Input Error: {err}")
            return False  
        except Exception as e:
            print(f"\n Unexpected error occurred: {e}")
            return False

    def view_expenses(self):
        try:
            if not self.expenses:
                print("\n No expense records found.")
                return
            print("\n" + " = " * 65)
            print(
                f"{'No.':<5} | {'Date':<12} | {'Category':<12} | {'Amount':<8} |"
                f"{'Description'}"
            )
            print("=" * 65)
            for idx, exp in enumerate(self.expenses, start=1):
                print(
                    f"{idx:<5} | {exp.date:<12} | {exp.category.title():<12} |"
                    f" {exp.amount:<7} | {exp.description}"
                )
                print("="*65)
        except Exception as e:
            print(f"\n Error while displaying expense: {e}")

    def delete_expense(self, index_str):
        try:
            if not self.expenses:
                print("\n No records availabe to delte.")
                return
            index = int(index_str) - 1

            if 0 <= index < len(self.expenses):
                removed = self.expenses.pop(index)
                self.save_expenses()
                print(
                    f"\n Deleted successfully: [{removed.category.title()} -"
                    f" {removed.amount}]"
                )
            else:
                print("\n Error: This expense number does not exist in the list.")

        except ValueError:
            print("\n Invalid Input: please enter a valid number.")
        except Exception as e:
            print(f"\n Error while deleting expenses: {e}")

    def view_total_and_category_summary(self):
        try:
            if not self.expenses:
                print("\n No records available for summary.")
                return
            total_expense = sum(exp.amount for exp in self.expenses)
            print(f"\n Total Expenses: {total_expense}")

            category_summary = {}
            for exp in self.expenses:
                category_summary[exp.category] = (
                    category_summary.get(exp.category, 0) + exp.amount
                )
            print("\n Category-wise Summary:")
            for cat, amt in category_summary.items():
                print(f" -{cat.title()}: {amt}")

        except Exception as e:
            print(f"\n Error while generating summary: {e}")

    def save_expenses(self):
        """Securely saves data to a JSON file."""
        try:
            with open(self.filename, "w") as file:
                json_data = [exp.to_dict() for exp in self.expenses]
                json.dump(json_data, file, indent=4)
        except PermissionError:
            print("Error: Permission denied to write file.")
        except IOError as e:
            print(f" File I/O Error: {e}")

    def load_expenses(self):
        """Loads data from the file and handles corrupted file errors gracefully."""
        try:
            with open(self.filename, "r") as file:
                data = json.load(file)
                print(f"DEBUG: File se inta data mila -> {data}")
                self.expenses = [
                    Expense(
                        d.get("amount",0.0),
                        d.get("category", "general"),
                        d.get("description", ""),
                        d.get("date"),
                    )
                    for d in data
                ]
                print(
                    f"DEBUG: List mein itne objects bane -> {len(self.expenses)}"
                )
        except FileNotFoundError:
            self.expenses = []
        except json.JSONDecodeError: 
            print(
                 " Warning: Data file is corrupted or empty. Starting with a fresh"
                "list."
            )
            self.expenses = []
        except Exception as e:
            print(f" Warning: An unexpected error occurred while loading file: {e}")
            self.expenses = []

    # ------- CLI Main Menu System -------  
def main():
    tracker = ExpenseTracker()

    while True:
        print("\n--- Personal Expense Tracker---")
        print("1. Add New Expense")
        print("2. View All Expense")
        print("3. View Total & Category-wise Summary")
        print("4. Delete an Expense")
        print("5. Exit")

        try:
            choice = input("Enter your choice (1-5): ").strip()

            if choice == "1":
                amount_input = input("Enter amount ($): ").strip()
                category_input = input(
                    "Enter category (e.g., Food, Travel, Bills): "
                ).strip()
                desc_input = input("Enter description/notes: ").strip()

                date_input = input(
                    "Enter Date (YYYY-MM-DD) or leave blank for today's date: "
                ).strip()
                custom_date = date_input if date_input else None
                tracker.add_expense(amount_input, category_input, desc_input, custom_date)
            elif choice == "2":
                tracker.view_expenses()
            elif choice == "3":
                tracker.view_total_and_category_summary()

            elif choice == "4":
                tracker.view_expenses()
                if tracker.expenses:
                    try:
                        del_choice = int(input(
                            "Enter the expense number you want to delete:").strip()
                        )
                        if 1 <= del_choice <=len(tracker.expenses):
                            removed = tracker.expenses.pop(del_choice -1)
                            tracker.save_expenses()
                            print("\n Expense deleted successfully!")
                        else:
                            print("\n Invalid expenses number.")
                    except ValueError:
                        print("\n Please enter a valid number.")
            elif choice == "5":
                print("\n Thank you for using Expense Tracker! Goodbye!")
                break
            else:
                print(" Invaild choice! Please selcet a number between 1 and 5.")

        except KeyboardInterrupt:
            print(
                "\n\n Program interrupted gracefully. Your data is safe. Goodbye!"
            )
            break
        except Exception as e:
            print(f"\n An unexpected error occurred: {e}")

if __name__ == "__main__":
    main()


# In[ ]:





# In[ ]:




