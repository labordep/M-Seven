Class {
	#name : #MSevenAeSurfaceBlElement4,
	#superclass : #BlElement,
	#instVars : [
		'map',
		'cameraSurface',
		'cameraResolution',
		'cameraAngle',
		'cameraPosition',
		'pattern',
		'scaleFactor'
	],
	#category : #'MSeven-POC'
}

{ #category : #drawing }
MSevenAeSurfaceBlElement4 >> aeDrawGeometryOn: aeCanvas [
	"Ignore geometry and other visual properties and directly show a fresh camera surface."

	| newScale |
	pattern ifNil:[ ^ self ].

	self refreshCameraSurface.
	
	"update scale factor"
	newScale := (self size / cameraResolution) roundTo: 0.1.
	newScale := (newScale x < newScale y ifTrue:[newScale x] ifFalse:[newScale y]).
	self scaleFactor: newScale. 
	
	aeCanvas privateAeCairoContext
		source: pattern;
		rectangleTo: self size;
		fill
]

{ #category : #accessing }
MSevenAeSurfaceBlElement4 >> cameraPosition: aPoint cameraAngle: aNumber [ 

	cameraPosition := aPoint.
	cameraAngle := aNumber.
	self invalidate
]

{ #category : #initialization }
MSevenAeSurfaceBlElement4 >> initialize [

	super initialize.
	
	scaleFactor := 1.0
]

{ #category : #accessing }
MSevenAeSurfaceBlElement4 >> map: aForm cameraResolution: aPoint [

	map := aForm flipHorizontally.
	cameraResolution := aPoint.

	"prepare view texture buffer"
	cameraSurface :=
		AeCairoImageSurface
			extent: cameraResolution
			format: AeCairoSurfaceFormat argb32.

	pattern := AeCairoSurfacePattern surface: cameraSurface.
	pattern filter: AeCairoSamplingFilter nearest.
]

{ #category : #initialization }
MSevenAeSurfaceBlElement4 >> refreshCameraSurface [

	| width height halfWidth halfHeight focalLens scale sin cos beginHeight bufferAddress horizontalLineByteLength |
	
	cameraResolution ifNil:[ ^ self ].
	
	width := cameraResolution x.
	height := cameraResolution y.
	halfWidth := (cameraResolution x / 2) asInteger.
	halfHeight := (cameraResolution y / 2) asInteger.
	focalLens := 250.
	scale := 100.
	sin := cameraAngle sin.
	cos := cameraAngle cos.
	beginHeight := height * 0.2.

	bufferAddress := cameraSurface data.
	horizontalLineByteLength := cameraSurface stride.

	"iterating over the screen array"
	1 to: width do: [ :i |
		beginHeight ceiling to: height do: [ :j |
			| x y z px py rx ry floorPos floorColor attenuation |
			"x y z"
			x := halfWidth - i.
			y := j + focalLens.
			z := j - beginHeight + 0.01.
			
			"rotation"
			rx := (x * cos) - (y * sin).
			ry := (x * sin) + (y * cos).
			
			"projection"
			px := rx / z + (cameraPosition y) * scale.
			py := ry / z + (cameraPosition x negated) * scale.
			
			"floor pixel pos and color"
			floorPos := Point
				x: ((px \\ (map extent x)) asInteger)
				y: ((py \\ (map extent y)) asInteger). 
			floorColor := map colorAt: floorPos.
			
			"shading & fog"
			attenuation := (10 * ((z abs) / halfHeight)) max: 0; min: 1.
			floorColor := floorColor adjustBrightness: ((1 - (attenuation))).
			
			"fill a pixel"
			bufferAddress
				uint32AtOffset: ((j - 1) * horizontalLineByteLength) + ((i - 1) << 2)
				put: floorColor asPremultipliedARGB32Integer 
		]. 
	].

	cameraSurface markDirty
]

{ #category : #accessing }
MSevenAeSurfaceBlElement4 >> scaleFactor: aFloat [

	scaleFactor ~= aFloat ifTrue:[

		scaleFactor := aFloat.
		
		"By default, patterns have the identity matrix.
		Then, we will only change it if really needed."
		(scaleFactor closeTo: 1.0) ifFalse: [
			pattern matrix: (AeCairoMatrix	newScalingByX: 1.0 / scaleFactor y: 1.0 / scaleFactor)
		]
		
	].
]