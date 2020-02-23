Class {
	#name : #JbFunctionCallNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'arguments'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionCallNode >> arguments [
	^ arguments
]

{ #category : #accessing }
JbFunctionCallNode >> arguments: anObject [
	arguments := anObject
]

{ #category : #Extensions }
JbFunctionCallNode >> evaluateIn: environment [

	"Need to evaluate each argument from the passed in JbEnvironment"
	
	| allArgs |
	allArgs := arguments collect: [ :arg | arg evaluateIn: environment ].
	
	^ (environment at: identifier) call: allArgs in: environment
]

{ #category : #Extensions }
JbFunctionCallNode >> executeIn: anEnvironment [

	^self evaluateIn: anEnvironment
]

{ #category : #accessing }
JbFunctionCallNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbFunctionCallNode >> identifier: anObject [
	identifier := anObject
]
