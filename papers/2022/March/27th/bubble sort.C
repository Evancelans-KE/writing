// Import the required libraries
using System;

class GFG
{
	static void bubbleSort(int []arr)
	{
		int n = arr.Length;
		for (int i = 0; i < n - 1; i++)
			for (int j = 0; j < n - i - 1; j++)
				if (arr[j] > arr[j + 1])
				{
					// begin swap of arrays 
					int temp = arr[j];
					arr[j] = arr[j + 1];
					arr[j + 1] = temp;
				}
	}

	/* Display the array*/
	static void printArray(int []arr)
	{
		int n = arr.Length;
		for (int i = 0; i < n; ++i)
			Console.Write(arr[i] + " ");
		Console.WriteLine();
	}

	
	public static void Main()
	{
		int []arr = {100, 1,000, 10,000, 25,000, 50,000, 100,000, 250,000, 500,000, 750,000,1,000,000};
		bubbleSort(arr);
		Console.WriteLine("Array was sorted succcesfuly ...");
		printArray(arr);
	}

}

 
 
