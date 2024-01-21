Class {
	#name : #MSevenPOC1,
	#superclass : #Object,
	#instVars : [
		'floorTexture',
		'floorTextureSize',
		'screen',
		'screenResolution',
		'space',
		'cameraMove',
		'view'
	],
	#category : #'MSeven-POC'
}

{ #category : #'pyramid-serialized-bloc' }
MSevenPOC1 class >> start [
	<script>
	
	self new.
]

{ #category : #'pyramid-serialized-bloc' }
MSevenPOC1 class >> testView [
	"This class has been generated using Pyramid.

	By: labordep
	2023-10-12 00:03:11"

	<pySTON>
	^ '[
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutMatchParentResizer { }
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : @6
			},
			#position : Point [ 0.0, 0.0 ],
			#margin : BlInsets {
				#top : 0.0,
				#left : 0.0,
				#bottom : 0.0,
				#right : 0.0
			},
			#padding : @9,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : Float [ #infinity ],
			#maxWidth : @10,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#background : BlPaintBackground {
				#paint : BlColorPaint {
					#color : Color {
						#red : 0.6920821114369502,
						#green : 0.4359726295210166,
						#blue : 0.24926686217008798,
						#alpha : 1.0
					}
				}
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #Map
			}
		},
		#layout : BlFlowLayout {
			#measurer : BlFlowLayoutMeasurer {
				#layout : @17,
				#children : OrderedCollection [ ],
				#lines : OrderedCollection [
					BlFlowLayoutLine {
						#children : OrderedCollection [ ],
						#startLength : 0,
						#startBreadth : 0,
						#length : 0,
						#breadth : 0,
						#measurer : @18
					}
				],
				#orientation : BlFlowLayoutHorizontal { },
				#maxWidth : 800.0,
				#maxHeight : 600.0,
				#widthMode : BlMeasurementSpec {
					#size : 800.0,
					#mode : BlMeasurementExactMode { }
				},
				#heightMode : BlMeasurementSpec {
					#size : 600.0,
					#mode : @25
				},
				#checkCanFit : true
			},
			#orientation : BlLayoutHorizontal { },
			#horizontalAlignment : BlHorizontalStartAlignment { },
			#verticalAlignment : BlTopAlignment { }
		},
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @2,
			#handlers : [
				
			]
		}
	}
]'
]

{ #category : #initialization }
MSevenPOC1 >> initialize [

	super initialize.

	screenResolution := 256 @ 240.
	view := self class testView materializeAsBlElement first.

	self loadTexture: MSevenResources ground_checkerboard in: view.

	space := view openInSpace.
	space addEventHandler: (BlEventHandler
			 on: BlSpaceResizedEvent
			 do: [ screen scaledToSize: space extent ]).

	cameraMove := [
	              | position |
	              position := 0 @ 0.
	              [ space isOpened ] whileTrue: [
		              | angle time |
		              position ifNil: [ position := 0 @ 0 ].
		              time := [
		                      position := position + (0.01 @ 0).
		                      angle := (position x * 0.3) sin.
		                      self
			                      moveCameraToPosition: position
			                      angle: angle ] timeToRun asMilliSeconds.
		              (16 - time max: 1) milliSeconds wait.
		              view background:
			              (BlImageBackground image: screen copy) ] ]
		              forkAt: Processor userBackgroundPriority
		              named: 'M-SevenPOC1'
]

{ #category : #texture }
MSevenPOC1 >> initializeTexture: aForm [

	floorTexture := aForm.
	floorTextureSize := floorTexture width @ floorTexture height. 
	screen := (Form extent: screenResolution depth: 8) fillBlack.
	
	^ screen
	
]

{ #category : #texture }
MSevenPOC1 >> loadTexture: anImage in: aBlElement [

	| background screenImage |
	
	"Transform image as Mode7"
	screenImage := self initializeTexture: anImage.
	
	"Apply to a background"
	background := BlImageBackground image: screenImage. 
	
	aBlElement background: background.
]

{ #category : #moving }
MSevenPOC1 >> moveCameraToPosition: aPoint [

	^ self moveCameraToPosition: aPoint angle: 0
]

{ #category : #moving }
MSevenPOC1 >> moveCameraToPosition: aPoint angle: anAngle [

	| width height halfWidth halfHeight focalLens scale position sin cos |

	width := screenResolution x.
	height := screenResolution y.
	halfWidth := (screenResolution x / 2) asInteger.
	halfHeight := (screenResolution y / 2) asInteger.
	focalLens := 250.
	scale := 100.
	position := aPoint.

	sin := anAngle sin.
	cos := anAngle cos.

	"iterating over the screen array"
	1 to: width do:[ :i | 
		(height * 0.3) to: height do:[ :j | | x y z px py rx ry floorPos floorColor attenuation |
			"x y z"
			x := halfWidth - i.
			y := j + focalLens.
			z := j - (height * 0.3) + 0.01.
			
			"rotation"
			rx := (x * cos) - (y * sin).
			ry := (x * sin) + (y * cos).
			
			"projection"
			px := rx / z + (position y) * scale.
			py := ry / z + (position x negated) * scale.
			
			"floor pixel pos and color"
			floorPos := ((px \\ (floorTextureSize x)) asInteger) @ ((py \\ (floorTextureSize y)) asInteger). 
			floorColor := floorTexture colorAt: floorPos.
			
			"shading & fog"
			attenuation := (1.5 * ((z abs) / halfHeight)) max: 0; min: 1.
			floorColor := floorColor adjustBrightness: ((1 - (attenuation)) negated).
			
			"fill screen"
			screen colorAt: (i@j) put: floorColor.
		].
	].

	^ screen
]
