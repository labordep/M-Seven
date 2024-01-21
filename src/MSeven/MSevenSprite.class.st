Class {
	#name : #MSevenSprite,
	#superclass : #Object,
	#instVars : [
		'form',
		'extent'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSevenSprite >> extent [

	^ extent ifNil:[ extent := self texture extent ]
]

{ #category : #accessing }
MSevenSprite >> extent: anObject [

	extent := anObject
]

{ #category : #accessing }
MSevenSprite >> texture [

	^ form
]

{ #category : #accessing }
MSevenSprite >> texture: aForm [

	form := aForm
]

{ #category : #texture }
MSevenSprite >> textureToDisplay [

	^ self texture
]
