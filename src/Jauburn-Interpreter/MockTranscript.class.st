"
Used for testing purposes
"
Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
MockTranscript >> contents [
	^ contents
]

{ #category : #streaming }
MockTranscript >> crShow: aMessage [

	contents := ('{1}{2}' format: {aMessage. (String with: Character cr)}).
]

{ #category : #streaming }
MockTranscript >> show: aMessage [

	contents := aMessage
]
