Class {
	#name : #MSevenWorld,
	#superclass : #Object,
	#instVars : [
		'ground',
		'actors'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSevenWorld >> actors [

	^ actors
]

{ #category : #accessing }
MSevenWorld >> actors: anObject [

	actors := anObject
]

{ #category : #accessing }
MSevenWorld >> ground [

	^ ground
]

{ #category : #accessing }
MSevenWorld >> ground: anObject [

	ground := anObject
]
