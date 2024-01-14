Class {
	#name : #MSevenWorldCameraViewBlElement,
	#superclass : #BlElement,
	#instVars : [
		'world',
		'camera',
		'resolution',
		'scaleFactor',
		'layersSurfacePattern',
		'layersSurface'
	],
	#category : #'MSeven-View'
}

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawGeometryOn: aeCanvas [
	"Ignore geometry and other visual properties and directly show a fresh camera surface."
	
	layersSurfacePattern ifNil:[ ^ self ].
	self camera ifNil:[ ^ self ].
	self world ifNil:[ ^ self ].
	self resolution ifNil:[ ^ self ].
	
	"draw layers"
	self updateLayersSurface.
	self aeDrawLayersOn: aeCanvas.
]

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawLayersOn: aeCanvas [
	
	aeCanvas privateAeCairoContext 
		source: layersSurfacePattern; 
		rectangleTo: self size; 
		fill
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> camera [

	^ camera
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> camera: anObject [

	camera := anObject
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> initialize [

	super initialize.
	self initializeLayersSurface.
	
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> initializeLayersSurface [

	self resolution ifNil:[ ^ self ].
	
	layersSurface := AeCairoImageSurface extent: self resolution format: AeCairoSurfaceFormat argb32.
	layersSurfacePattern := AeCairoSurfacePattern surface: layersSurface.
	layersSurfacePattern filter: AeCairoSamplingFilter nearest.
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> layersSurface [

	^ layersSurface
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> layersSurface: anObject [

	layersSurface := anObject
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> prepareWorld [

	
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> resolution [

	^ resolution
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> resolution: anObject [

	resolution = anObject ifTrue:[ ^ self ].
	resolution := anObject.
	self initializeLayersSurface.
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> scaleFactor [

	^ scaleFactor ifNil:[ scaleFactor := 1.0 ]
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> scaleFactor: aFloat [

	scaleFactor = aFloat ifTrue:[ ^ self ].
	scaleFactor := aFloat.
	self updatePattern.
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> size: aPoint [

	| newScale |
	super size: aPoint.
	
	self resolution ifNil:[ ^ self ].
	
	"update scale factor"
	newScale := (self size / self resolution).
	newScale := (newScale x < newScale y ifTrue:[ newScale x ] ifFalse:[ newScale y ]).
	self scaleFactor: newScale.
]

{ #category : #updating }
MSevenWorldCameraViewBlElement >> updateLayersSurface [

	| width height halfWidth halfHeight sin cos beginHeight altitude bufferAddress horizontalLineByteLength scale layer layerExtent |
	width := self resolution x.
	height := self resolution y.
	halfWidth := (self resolution x / 2) asInteger.
	halfHeight := (self resolution y / 2) asInteger.
	sin := self camera coordinates pitch sin.
	cos := self camera coordinates pitch cos.
	beginHeight := height * 0.2.
	altitude := self camera coordinates position z.
	bufferAddress := layersSurface data.
	horizontalLineByteLength := layersSurface stride.
	scale := 100.
	
	"only one layer for this POC"
	layer := self world layers first. 
	layerExtent := layer texture extent.
	
	"iterating over the screen array"
	1 to: width do: [ :i |
		beginHeight ceiling to: height do: [ :j |
			| x y z px py rx ry floorPos floorColor attenuation |
			"x y z"
			x := halfWidth - i.
			y := j + self camera fieldOfView.
			z := j - beginHeight + altitude.
			
			"rotation"
			rx := (x * cos) - (y * sin).
			ry := (x * sin) + (y * cos).
			
			"projection"
			px := rx / z + (self camera coordinates position y) * scale.
			py := ry / z + (self camera coordinates position x negated) * scale.
			
			"floor pixel pos and color"
			floorPos := Point
				x: ((px \\ (layerExtent x)) asInteger)
				y: ((py \\ (layerExtent y)) asInteger). 
			floorColor := layer texture colorAt: floorPos.
			
			"shading & fog"
			attenuation := (10 * ((z abs) / halfHeight)) max: 0; min: 1.
			floorColor := floorColor adjustBrightness: ((1 - (attenuation))).
			
			"fill a pixel"
			bufferAddress
				uint32AtOffset: ((j - 1) * horizontalLineByteLength) + ((i - 1) << 2)
				put: floorColor asPremultipliedARGB32Integer.
		]. 
	].

	layersSurface markDirty
]

{ #category : #updating }
MSevenWorldCameraViewBlElement >> updatePattern [
	
	layersSurfacePattern ifNil:[ ^ self ].
	self scaleFactor ifNil:[ ^ self ].

	"By default, patterns have the identity matrix.
	Then, we will only change it if really needed."
	(scaleFactor closeTo: 1.0) ifFalse: [
		layersSurfacePattern matrix: (AeCairoMatrix	newScalingByX: (1.0 / self scaleFactor) y: (1.0 / self scaleFactor))
	]
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> world [

	^ world
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> world: anObject [

	world = anObject ifTrue:[ ^ self ].
	world := anObject.
	self prepareWorld.
]
