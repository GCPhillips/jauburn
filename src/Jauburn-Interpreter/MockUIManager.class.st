"
Used for testing purposes
"
Class {
	#name : #MockUIManager,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #services }
MockUIManager >> contents [ 

	^ contents
]

{ #category : #services }
MockUIManager >> textEntry: aPrompt [

	contents := aPrompt
]
