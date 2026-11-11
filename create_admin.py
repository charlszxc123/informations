#!/usr/bin/env python
"""
Script to create a Django admin superuser account.
This script can be run directly from the command line.
"""
import os
import sys
import django

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'attendance_system.settings')
django.setup()

# Import Django models after setting up the environment
from django.contrib.auth.models import User
from django.db.utils import IntegrityError

def create_superuser(username, email, password):
    """
    Create a superuser with the provided credentials.
    
    Args:
        username (str): The admin username
        email (str): The admin email
        password (str): The admin password
    
    Returns:
        bool: True if user created successfully, False otherwise
    """
    try:
        # Check if user already exists
        if User.objects.filter(username=username).exists():
            print(f"User '{username}' already exists!")
            return False
        
        # Create superuser
        user = User.objects.create_superuser(
            username=username,
            email=email,
            password=password
        )
        print(f"Superuser '{username}' created successfully!")
        return True
    
    except IntegrityError:
        print(f"Error: Could not create user '{username}'. Username may be taken.")
        return False
    except Exception as e:
        print(f"Error creating superuser: {str(e)}")
        return False

def main():
    """Main function to get user input and create the superuser."""
    print("\n=== Create Django Admin Superuser ===\n")
    
    # Get user input
    username = input("Enter username (default: admin): ").strip() or "admin"
    email = input("Enter email (default: admin@example.com): ").strip() or "admin@example.com"
    
    # Get password with confirmation
    while True:
        password = input("Enter password: ").strip()
        if not password:
            print("Password cannot be empty!")
            continue
            
        password_confirm = input("Confirm password: ").strip()
        if password != password_confirm:
            print("Passwords do not match! Try again.")
            continue
        break
    
    # Create the superuser
    success = create_superuser(username, email, password)
    
    if success:
        print("\nSuperuser created successfully!")
        print(f"Username: {username}")
        print(f"Email: {email}")
        print("\nYou can now log in to the admin panel at http://127.0.0.1:8000/admin/")
    else:
        print("\nFailed to create superuser. Please try again with different credentials.")

if __name__ == "__main__":
    main() 