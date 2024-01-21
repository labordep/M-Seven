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
		'stepScaleFactor',
		'horizonProportion'
	],
	#category : #'MSeven-View'
}

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawActorsOn: aeCanvas [

	| res halfWidth height horizonHeight altitude sin cos cameraY cameraXNegated halfHeight |
	
	true ifTrue:[^ self ].
	
	res := stepResolution ifNil:[ ^ self ].
	height := res y.
	halfWidth := (res x / 2) asInteger.
	halfHeight := (res y / 2) asInteger.
	sin := self camera pose yaw sin.
	cos := self camera pose yaw cos.
	horizonHeight := (height * self horizonProportion) ceiling.
	altitude := self camera pose z.
	cameraY := self camera pose y.
	cameraXNegated := self camera pose x negated.

	self world actors do: [ :actor | | actorPos |
		
		actorPos := (actor pose position x) @ (actor pose position y).
		
		"draw actors"
		aeCanvas restoreContextAfter: [
			aeCanvas pathTranslate: actorPos.
			aeCanvas pathFactory: [ :cairoContext |
				cairoContext rectangleTo: actor sprite extent. 
			].
			aeCanvas setBackgroundWithForm: actor sprite textureToDisplay alpha: 1.0.
			aeCanvas setBorderOff.
			aeCanvas drawFigure.
		].		
	].
]

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawGeometryOn: aeCanvas [
	"Draw directly to show a fresh camera surface."
	
	self aeDrawLayersOn: aeCanvas.
	self aeDrawActorsOn: aeCanvas.
]

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawGroundLayersOn: aeCanvas [

	aeCanvas privateAeCairoContext 
		source: layersSurfacePattern; 
		rectangleTo: self size; 
		fill
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
	
	self aeDrawSkyLayersOn: aeCanvas.
	self aeDrawGroundLayersOn: aeCanvas.
]

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawSkyLayersOn: aeCanvas [

	| res width height layer horizonHeight rectangle yaw layerExtent x y |
	
	res := stepResolution ifNil:[ ^ self ].
	width := res x.
	height := res y.
	horizonHeight := (height * self horizonProportion) ceiling.
	yaw := self camera pose yaw.
	"one sky for instant"
	layer := (self world layers select:[ :e | e isSky ]) first.
	layerExtent := layer sprite extent ifNil:[ ^ self ].
	rectangle := (layerExtent x @ (horizonHeight / scaleFactor)).
	x := ((rectangle x) * (yaw negated / 2)).
	y := 0.

	aeCanvas restoreContextAfter: [
		aeCanvas pathTranslate: x@y.
		aeCanvas pathFactory: [ :cairoContext |
			cairoContext rectangleTo: rectangle. 
		].
		aeCanvas setBackgroundWithForm: layer sprite textureToDisplay alpha: 1.0.
		aeCanvas setBorderOff.
		aeCanvas drawFigure.		
	].
]

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> applyYaw: anAngle to: aPoint3D [
    | cosYaw sinYaw rotatedX rotatedY rotatedZ |

    cosYaw := anAngle cos.
    sinYaw := anAngle sin.

    "Appliquer la rotation autour de l'axe vertical (y)"
    rotatedX := (aPoint3D x * cosYaw) + (aPoint3D z * sinYaw).
    rotatedY := aPoint3D y.
    rotatedZ := (aPoint3D z * cosYaw) - (aPoint3D x * sinYaw).

    ^ BlPoint3D x: rotatedX y: rotatedY z: rotatedZ.

]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> camera [

	^ camera
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> camera: anObject [

	camera := anObject
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> horizonProportion [
	"return the place of the horizon in % of the resolution height"

	^ horizonProportion ifNil:[ horizonProportion := 0.2 ]
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> horizonProportion: anObject [

	horizonProportion := anObject
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> initialize [

	super initialize.
	self installHandlers.
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
MSevenWorldCameraViewBlElement >> installHandlers [

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

{ #category : #private }
MSevenWorldCameraViewBlElement >> normalizeCoordinates: point screenWidth: width screenHeight: height [
	"Normalisation des coordonnées entre -1 et 1"

	^ point x / width * 2 - 1 @ (1 - point y / height * 2)
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> prepareWorld [

	
]

{ #category : #projection }
MSevenWorldCameraViewBlElement >> project2DIsometricPointX: x y: y [

	| sin cos |
	sin := self camera pose yaw sin.
	cos := self camera pose yaw cos.
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

	| width height halfWidth halfHeight sin cos horizonHeight altitude bufferAddress horizontalLineByteLength scale layer layerExtent res cameraY cameraXNegated texture |
	
	res := stepResolution ifNil:[ ^ self ].
	
	width := res x.
	height := res y.
	halfWidth := (res x / 2) asInteger.
	halfHeight := (res y / 2) asInteger.
	sin := self camera pose yaw sin.
	cos := self camera pose yaw cos.
	horizonHeight := (height * self horizonProportion) ceiling.
	altitude := self camera pose z.
	cameraY := self camera pose y.
	cameraXNegated := self camera pose x negated.
	bufferAddress := layersSurface data.
	horizontalLineByteLength := layersSurface stride.
		
	"only one layer for this POC"
	layer := (self world layers select:[ :e | e isGround ]) first. 
	scale := layer scale.
	layerExtent := layer sprite extent ifNil:[ ^ self ].
	texture := layer sprite textureToDisplay.
	
	"iterating over the screen array"
	1 to: width do: [ :i |
		horizonHeight to: height do: [ :j |
			| x y z px py rx ry floorPos floorColor attenuation |
			"x y z"
			x := halfWidth - i.
			y := (j + self camera fieldOfView).
			z := (j - horizonHeight) max: 0.0001.
			
			"yaw processing"
			rx := (x * cos) - (y * sin).
			ry := (x * sin) + (y * cos).
			
			"projection"
			px := rx / z + cameraY * scale.
			py := ry / z + cameraXNegated * scale.
			
			"floor pixel pos and color"
			floorPos := (layerExtent x - ((px \\ (layerExtent x)) asInteger) - 1)
				@ (layerExtent y - ((py \\ layerExtent y) asInteger) - 1).
			floorColor := texture colorAt: floorPos.
			
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
