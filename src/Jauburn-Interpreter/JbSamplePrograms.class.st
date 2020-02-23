"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> findGCD [

Transcript clear.

^'
	var gcd = function(a, b) 
	{
		var temp1 = mod(a,b);
		if (temp1 == 0) 
		{ 		
			return b; 
		}
		else
		{
			return gcd(b, temp1);
		}
	};
	var userInput1 = input("Enter the first number");
	var userInput2 = input("Enter the second number");
	
	var result = gcd(userInput1, userInput2);
	
	print(concat("Using the Euclidean method, the GCD of ", userInput1));
	print(concat(" and ", userInput2));
	print(concat(" is: ", result));
'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> findSqrt [

Transcript clear.

^'
	var userInput = input("Enter the number to find the square root");
	var tries = input("Enter the number of approximations");
	println(concat("Approximating the square root of ", userInput));
	var r = userInput;
	var div = 0;
	var num = 0;
	while (tries > 0)
	{ 
		div = userInput / r;
		num = r + div;
		r = num / 2;
		println(concat("Approximation: ", r));
		tries = tries - 1;
	}
	println(" ");
	println(concat("The result is: ", r));	
'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]
