Class {
	#name : 'MSevenWorldLayer',
	#superclass : 'Object',
	#instVars : [
		'name',
		'sprite'
	],
	#category : 'MSeven-Model',
	#package : 'MSeven',
	#tag : 'Model'
}

{ #category : 'testing' }
MSevenWorldLayer >> isGround [

	^ false
]

{ #category : 'testing' }
MSevenWorldLayer >> isSky [

	^ false
]

{ #category : 'accessing' }
MSevenWorldLayer >> name [

	^ name
]

{ #category : 'accessing' }
MSevenWorldLayer >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
MSevenWorldLayer >> sprite [

	^ sprite
]

{ #category : 'accessing' }
MSevenWorldLayer >> sprite: anObject [

	sprite := anObject
]
