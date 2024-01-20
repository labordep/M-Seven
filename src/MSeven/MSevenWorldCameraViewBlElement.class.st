Class {
	#name : #MSevenWorldCameraViewBlElement,
	#superclass : #BlElement,
	#instVars : [
		'world',
		'camera',
		'resolution',
		'scaleFactor',
		'layersSurfacePattern',
		'layersSurface',
		'stepResolution',
		'stepScaleFactor'
	],
	#category : #'MSeven-View'
}

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawGeometryOn: aeCanvas [
	"Draw directly to show a fresh camera surface."
	
	self aeDrawLayersOn: aeCanvas.
]

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawIgnoringOpacityAndTransformationOn: aeCanvas [
	
	"compute dirty values if needed"
	stepResolution ~= self resolution ifTrue:[
		stepResolution := self resolution.	
		self initializeLayersSurface.
	].
	
	stepScaleFactor ~= self scaleFactor ifTrue:[
		stepScaleFactor := self scaleFactor.
		self updatePattern.	
	].
	
	stepResolution ifNil:[ ^ self ].
	stepScaleFactor ifNil:[ ^ self ].
	self camera ifNil:[ ^ self ].
	self world ifNil:[ ^ self ].
		
	"compute drawed layer"
	self updateLayersSurface.
	
	super aeDrawIgnoringOpacityAndTransformationOn: aeCanvas
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
	self installListeners.
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> initializeLayersSurface [

	| extent |
	extent := stepResolution ifNil:[ ^ self ].
	
	layersSurface := AeCairoImageSurface extent: extent format: AeCairoSurfaceFormat argb32.
	layersSurfacePattern := AeCairoSurfacePattern surface: layersSurface.
	layersSurfacePattern filter: AeCairoSamplingFilter nearest.
	
	self updatePattern.
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> installListeners [

	self addEventHandler: (BlEventHandler
			 on: BlElementLayoutComputedEvent
			 do: [ self updateScale ])
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

	resolution := anObject.
	
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> scaleFactor [

	^ scaleFactor ifNil:[ scaleFactor := 1.0 ]
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> scaleFactor: aFloat [

	scaleFactor := aFloat
]

{ #category : #updating }
MSevenWorldCameraViewBlElement >> updateLayersSurface [

	| width height halfWidth halfHeight sin cos beginHeight altitude bufferAddress horizontalLineByteLength scale layer layerExtent res |
	
	res := stepResolution ifNil:[ ^ self ].
	
	width := res x.
	height := res y.
	halfWidth := (res x / 2) asInteger.
	halfHeight := (res y / 2) asInteger.
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
	
	stepScaleFactor ifNil:[ ^ self ].
	layersSurfacePattern ifNil:[ ^ self ].

	"By default, patterns have the identity matrix.
	Then, we will only change it if really needed."
	(stepScaleFactor closeTo: 1.0) ifFalse: [
		layersSurfacePattern matrix: (AeCairoMatrix	newScalingByX: (stepScaleFactor) y: (stepScaleFactor))
	]
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> updateScale [

	| newScale |
	self resolution ifNil: [ ^ self ].

	"update scale factor"
	newScale := self resolution / self size.
	newScale := newScale x min: newScale y.
	self scaleFactor: newScale
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
