Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #Extensions }
JbIfElseNode >> executeIn: anEnvironment [

	| val |

	val := (condition evaluateIn: anEnvironment).
	val 
		ifTrue: [ 
			trueStatements allButLast do: [:each | each executeIn: anEnvironment ].
			^ trueStatements last executeIn: anEnvironment.]
		ifFalse: [
			falseStatements allButLast do: [:each | each executeIn: anEnvironment ].
			^ falseStatements last executeIn: anEnvironment.].
]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
