Class {
	#name : #MSevenAeSurfaceBlElement,
	#superclass : #BlElement,
	#instVars : [
		'surface'
	],
	#category : #'MSeven-POC'
}

{ #category : #drawing }
MSevenAeSurfaceBlElement >> aeDrawOn: aeCanvas [

	surface ifNil:[ ^ self ].
	
    self aeDrawOn: aeCanvas with: [

        "My position is applied before my transformation matrix,
        which may have an additional translation."
        aeCanvas pathTranslate: self position.
        self transformation aeApplyTo: aeCanvas.

        aeCanvas privateAeCairoContext
            sourceSurface: surface x: 0 y: 0;
            paint 
        ]    
]

{ #category : #drawing }
MSevenAeSurfaceBlElement >> surface [

	^ surface
]

{ #category : #drawing }
MSevenAeSurfaceBlElement >> surface: aSurface [

	surface := aSurface
]
