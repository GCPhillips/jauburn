Class {
	#name : #JbIfNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfNode >> condition [
	^ condition
]

{ #category : #accessing }
JbIfNode >> condition: anObject [
	condition := anObject
]

{ #category : #Extensions }
JbIfNode >> executeIn: anEnvironment [

	| val |

	val := (condition evaluateIn: anEnvironment).
	
	^	val 
		ifTrue: [ trueStatements do: [:each | each executeIn: anEnvironment ].]
		ifFalse: [ false ]
]

{ #category : #accessing }
JbIfNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbIfNode >> trueStatements: anObject [
	trueStatements := anObject
]
