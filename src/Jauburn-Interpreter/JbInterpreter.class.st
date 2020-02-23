"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'transcript',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
	^ #abs -> [ :v1 | v1 abs]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^ #concat -> [ :v1 :v2 | 
			(v1 isString 
				ifTrue: [ v1 ]
				ifFalse: [v1 printString]), 
			(v2 isString 
				ifTrue: [ v2 ]
				ifFalse: [v2 printString]).]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	self initializeEnvBindings.
]

{ #category : #initialization }
JbInterpreter >> initializeEnvBindings [
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| prim binding |
				binding := self perform: s.
				prim := JbPrimitive new.
				prim block: binding value.
				environment at: binding key put: prim]
]

{ #category : #primitives }
JbInterpreter >> inputBinding [
	^ #input -> [ :value | | theValue |
			theValue := self uimanager textEntry: value.
			[theValue asNumber] on: Error do: 
				[ theValue ]. ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
	^ #length -> [ :v1 | v1 size]
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^ #mod -> [ :v1 :v2 | v1 \\ v2]
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^ #not -> [ :v1 | v1 not]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^ #print -> [ :value | self transcript show: value ]
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [
	^ #println -> [ :value | self transcript crShow: value ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #accessing }
JbInterpreter >> transcript [

	^ transcript ifNil: [ Transcript]
]

{ #category : #accessing }
JbInterpreter >> transcript: aTranscript [

	transcript := aTranscript
]

{ #category : #accessing }
JbInterpreter >> uimanager [

	^ uimanager ifNil: [ MorphicUIManager new.]
]

{ #category : #accessing }
JbInterpreter >> uimanager: aUiManager [

	uimanager := aUiManager
]
