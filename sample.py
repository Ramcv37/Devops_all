# Simple Python script to add two numbers

def add_numbers(num1, num2):
    """Function to add two numbers"""
    return num1 + num2

def main():
    """Main function to take input and display the result"""
    try:
        # Taking input from the user
        num1 = float(input("Enter the first number: "))
        num2 = float(input("Enter the second number: "))
        
        # Calculating the sum using the add_numbers function
        result = add_numbers(num1, num2)
        
        # Displaying the result
        print(f"The sum of {num1} and {num2} is: {result}")
    
    except ValueError:
        print("Invalid input. Please enter valid numbers.")

if __name__ == "__main__":
    # Calling the main function if the script is executed
    main()
