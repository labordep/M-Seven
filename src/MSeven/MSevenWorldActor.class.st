Class {
	#name : #MSevenWorldActor,
	#superclass : #MSevenWorldEntity,
	#instVars : [
		'pose',
		'sprite'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSevenWorldActor >> pose [

	^ pose ifNil:[ pose := MSevenPose new ]
]

{ #category : #accessing }
MSevenWorldActor >> pose: anObject [

	pose := anObject
]

{ #category : #accessing }
MSevenWorldActor >> sprite [

	^ sprite
]

{ #category : #accessing }
MSevenWorldActor >> sprite: aSprite [

	sprite := aSprite
]
