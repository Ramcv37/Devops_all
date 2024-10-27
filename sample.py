# Simple Python script to print a greeting with the current date

import datetime

def print_greeting():
    """Function to print a greeting with the current date"""
    current_date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    greeting = f"Hi! Today's date and time are: {current_date}"
    print(greeting)

def main():
    """Main function to call print_greeting"""
    print_greeting()

if __name__ == "__main__":
    # Calling the main function if the script is executed
    main()
