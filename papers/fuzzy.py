#define an new function to execute code
def fuzzy_check():
    n = int(input("Enter Number of Institutes: ")) #promt user for the nunber of institutes
def check_float(f1):
    try:#in case we have bugs, use the try syntax to handle
        float(f1)
        return True
    except: 
        return False
    while n:# start our loop condition, validate the inputs and check for return statements
        faith = input("Enter Faith Value of Institute: ")
        if not check_float(faith):
            print("\tInvalid Value...")
        else: 
            faith = float(faith)
            if 0<=faith<0.3:
                print("\t--> Don't take admission")
            elif 0.3<=faith<0.5:
                print("\t--> Not recommended. But you may consider.")
            elif 0.5<=faith<0.8:
                print("\t--> Good institute to take admission.")
            elif 0.8<=faith<=1:
                print("\t--> Excellent institute. Highly recommended.")
            else:
                print("\tFuzzy Value must be between 0 and 1")
                n-=1
            return fuzzy_check()
    