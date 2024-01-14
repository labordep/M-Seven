Class {
	#name : #MSevenWorld,
	#superclass : #Object,
	#instVars : [
		'layers',
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

{ #category : #'accessing - actors' }
MSevenWorld >> addActor: anActor [

	self actors add: anActor
]

{ #category : #'accessing - layers' }
MSevenWorld >> addLayer: aLayer [

	self layers add: aLayer 
]

{ #category : #accessing }
MSevenWorld >> initialize [ 

	super initialize.
	self actors: OrderedCollection new.
	self layers: OrderedCollection new.
]

{ #category : #accessing }
MSevenWorld >> layers [

	^ layers
]

{ #category : #accessing }
MSevenWorld >> layers: anObject [

	layers := anObject
]
