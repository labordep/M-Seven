Class {
	#name : #MSevenWorldActor,
	#superclass : #MSevenWorldEntity,
	#instVars : [
		'coordinates',
		'sprite'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSevenWorldActor >> coordinates [

	^ coordinates ifNil:[ coordinates := MSevenCoordinates new ]
]

{ #category : #accessing }
MSevenWorldActor >> coordinates: anObject [

	coordinates := anObject
]

{ #category : #accessing }
MSevenWorldActor >> sprite [

	^ sprite
]

{ #category : #accessing }
MSevenWorldActor >> sprite: anObject [

	sprite := anObject
]
