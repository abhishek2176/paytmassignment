import java.util.Scanner;

public class PrimeNumbers
{
  static final int max_range = 100;

  public static void main (String[]args)
  {
     boolean isPrime = true;
	 String a = "";
	 
    Scanner input = new Scanner (System.in);

    int n = input.nextInt ();

/* Scenario - If Users enters 0 and 1,User will get the validation*/


	System.out.println (n + " is not a prime numb
    if (n == 0 || n == 1) 
      {er");

      }
/* Scenario - If User enters negative numbers or more than max_range, User will get the validation as well*/
    else if (n < 1 || n > max_range)
      {

	System.out.println ("The Number is outside the valid range");

      }

    else
      {
	for (int i = 2; i <= n; i++)
	  {
	    isPrime = checkPrime (i);
	    if (isPrime)
	      {
		           a = a + i + " ";
	      }
	  }
	System.out.println ("Prime numbers from 1 to " + max_range + " are:");
	System.out.println (a);

      }
  }
  static boolean checkPrime (int n)
  {

    for (int i = 2; i <= n / 2; i++)
      {
	if (n % i == 0)
	  {

	    return false;
	  }
      }
    return true;
  }

}
