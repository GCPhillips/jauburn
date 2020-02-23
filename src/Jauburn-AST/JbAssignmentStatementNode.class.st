Class {
	#name : #JbAssignmentStatementNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #Extensions }
JbAssignmentStatementNode >> evaluateIn: anEnvironment [
	^ self executeIn: anEnvironment 
]

{ #category : #Extensions }
JbAssignmentStatementNode >> executeIn: anEnvironment [
	anEnvironment lookupAt: identifier put: (expression evaluateIn: anEnvironment)
]

{ #category : #accessing }
JbAssignmentStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbAssignmentStatementNode >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
JbAssignmentStatementNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbAssignmentStatementNode >> identifier: anObject [
	identifier := anObject
]
