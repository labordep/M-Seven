Class {
	#name : #MSevenAeSurfaceBlElement3,
	#superclass : #BlElement,
	#instVars : [
		'map',
		'cameraSurface',
		'cameraResolution',
		'cameraAngle',
		'cameraPosition'
	],
	#category : #'MSeven-POC'
}

{ #category : #drawing }
MSevenAeSurfaceBlElement3 >> aeDrawGeometryOn: aeCanvas [
	"Ignore geometry and other visual properties and directly show a fresh camera surface."

	self refreshCameraSurface.
	aeCanvas privateAeCairoContext
		sourceSurface: cameraSurface x: 0.0 y: 0.0;
		paint
]

{ #category : #accessing }
MSevenAeSurfaceBlElement3 >> cameraPosition: aPoint cameraAngle: aNumber [ 

	cameraPosition := aPoint.
	cameraAngle := aNumber.
	self invalidate
]

{ #category : #initialization }
MSevenAeSurfaceBlElement3 >> map: aForm cameraResolution: aPoint [

	map := aForm.
	cameraResolution := aPoint.

	"prepare view texture buffer"
	cameraSurface :=
		AeCairoImageSurface
			extent: cameraResolution
			format: AeCairoSurfaceFormat argb32.
	cameraSurface newContext
		sourceColor: Color black;
		paint
]

{ #category : #initialization }
MSevenAeSurfaceBlElement3 >> refreshCameraSurface [

	| width height halfWidth halfHeight focalLens scale sin cos beginHeight bufferAddress horizontalLineByteLength |
	width := cameraResolution x.
	height := cameraResolution y.
	halfWidth := (cameraResolution x / 2) asInteger.
	halfHeight := (cameraResolution y / 2) asInteger.
	focalLens := 250.
	scale := 100.
	sin := cameraAngle sin.
	cos := cameraAngle cos.
	beginHeight := height * 0.3.

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
			attenuation := (1.5 * ((z abs) / halfHeight)) max: 0; min: 1.
			floorColor := floorColor adjustBrightness: ((1 - (attenuation)) negated).
			
			"fill a pixel"
			bufferAddress
				uint32AtOffset: ((j - 1) * horizontalLineByteLength) + ((i - 1) << 2)
				put: floorColor asPremultipliedARGB32Integer ] ].

	cameraSurface markDirty
]
