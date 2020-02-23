"
This tests interpretations of AST environments
"
Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser',
		'transcript',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new.
]

{ #category : #running }
JbInterpreterTest >> testABSPrimitive [
	
	self interpret: 'var x = abs(-155);'.
	self assert: (interpreter environment at: 'x') equals: 155.
	



]

{ #category : #running }
JbInterpreterTest >> testConcatPrimitive [
	
	self interpret: 'var x = concat("abc", "123");'.
	self assert: (interpreter environment at: 'x') equals: 'abc123'.
	
	self interpret: 'var a = "abc";
						var b = "123";
						var x = concat(a, b);'.
	self assert: (interpreter environment at: 'x') equals: 'abc123'.

]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 6 - 5;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 10 / 5;'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = 5; -x;'.
	self assert: (interpreter environment at: 'x') equals: 5.
	
	self interpret: 'var x = -5; -x;'.
	self assert: (interpreter environment at: 'x') equals: -5.
	
	self interpret: 'var x = 5 == 5;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 5 == 6;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 5 != 5;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 5 != 6;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 6 < 20;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 6 > 20;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 100 > 20;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 100 < 20;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 100 <= 100;'.
	self assert: (interpreter environment at: 'x') equals: true.	
	
	self interpret: 'var x = 100 >= 100;'.
	self assert: (interpreter environment at: 'x') equals: true.	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testFunctionDeclarationAndCall [

	self interpret: 'var x = function(a, b) {return a * b;};'.
	"Test function declaration.
	'x' will return a JbFunction.  
	These tests check that a JbFunction was created and returned."
	self assert: (interpreter environment at: 'x') parameters size equals: 2. "Parameters are a, b"
	self assert: (interpreter environment at: 'x') body size equals: 1.		"it is a JbReturnStatementNode"
			
	"Test function calling with return."
	self interpret: 'var y = x(5, 3);'.
	self assert: (interpreter environment at: 'y') equals: 15.
	
	"Test function calling with no return"
	self interpret: 'var y = 0;'.
	self interpret: 'var x = function() {y = 5;};'.
	self interpret: 'x();'.
	self assert: (interpreter environment at: 'y') equals: 5.
	
	"Test function calling with return"
	self interpret: 'var x = function() {return 55;};'.
	self interpret: 'var y = x();'.
	self assert: (interpreter environment at: 'y') equals: 55.
	
	"Test function calling with return"
	self interpret: 'var x = function() {if (false) { return 100;} else {return 55;};'.
	self interpret: 'var y = x();'.
	self assert: (interpreter environment at: 'y') equals: 55.

			
	
]

{ #category : #running }
JbInterpreterTest >> testIfElseStatement [
	
	self interpret: 'var x = 5; if (x < 6) {x = 200;} else {x = 100;}'.
	self assert: (interpreter environment at: 'x') equals: 200.
	
	self interpret: 'var x = 5; if (x > 6) {x = 200;} else {x = 123;}'.
	self assert: (interpreter environment at: 'x') equals: 123.
]

{ #category : #running }
JbInterpreterTest >> testIfStatement [
	
	self interpret: 'var x = 5; if (x < 6) {x = 200;}'.
	self assert: (interpreter environment at: 'x') equals: 200.
	
	self interpret: 'var x = 5; if (x > 6) {x = 200;}'.
	self assert: (interpreter environment at: 'x') equals: 5.


]

{ #category : #running }
JbInterpreterTest >> testInputPrimitive [

	| ui |
	
	ui := MockUIManager new.
	interpreter uimanager: ui.
	
	self interpret: 'var x = input("abc");'.
	self assert: (interpreter uimanager contents) equals: 'abc'.
]

{ #category : #running }
JbInterpreterTest >> testLengthPrimitive [
	
	self interpret: 'var x = length("abc");'.
	self assert: (interpreter environment at: 'x') equals: 3.
	
	self interpret: 'var a = "abc";
						  var x = length(a);'.
	self assert: (interpreter environment at: 'x') equals: 3.

]

{ #category : #running }
JbInterpreterTest >> testModPrimitive [
	
	self interpret: 'var x = mod(5, 4);'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var a = 5;
						var b = 3;
						var x = mod(a, b);'.
	self assert: (interpreter environment at: 'x') equals: 2.
	



]

{ #category : #running }
JbInterpreterTest >> testNotPrimitive [
	
	self interpret: 'var x = not(true);'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var a = false;
						var x = not(a);'.
	self assert: (interpreter environment at: 'x') equals: true.


]

{ #category : #running }
JbInterpreterTest >> testPrintPrimitive [

	| mt |
	
	mt := MockTranscript new.
	interpreter transcript: mt.
	
	self interpret: 'print("hello world!");'.
	self assert: (interpreter transcript contents) equals: 'hello world!'.

	self interpret: 'print(155);'.
	self assert:  mt contents equals: 155.
	
	self interpret: 'var x = 123; print(x);'.
	self assert:  mt contents equals: 123.
]

{ #category : #running }
JbInterpreterTest >> testPrintlnPrimitive [

	| mt |
	
	mt := MockTranscript new.
	interpreter transcript: mt.
	
	self interpret: 'println("hello world!");'.
	self assert: (interpreter transcript contents) equals: ('hello world!{1}' format: (String with: Character cr)).

	self interpret: 'println(155);'.
	self assert:  mt contents equals: ('155{1}' format: (String with: Character cr)).
	
	self interpret: 'var x = 123; println(x);'.
	self assert:  mt contents equals: ('123{1}' format: (String with: Character cr)).
]

{ #category : #running }
JbInterpreterTest >> testWhileLoop [
	
	self interpret: 
  'var y = 0; 
	var x = 1; 
	while(x <= 10) 
	{
		y = x + y; 
		x = x + 1;
	}'.
	self assert: (interpreter environment at: 'y') equals: 55.

]

{ #category : #utilities }
JbInterpreterTest >> transcript [

	^transcript
	
]

{ #category : #utilities }
JbInterpreterTest >> transcript: aTranscript [

	transcript := aTranscript
	
]

{ #category : #utilities }
JbInterpreterTest >> uimanager [ 

	^uimanager
	
]

{ #category : #utilities }
JbInterpreterTest >> uimanager: aUiManager [

	uimanager := aUiManager
	
]
