Class {
	#name : #MSevenPOC2,
	#superclass : #Object,
	#instVars : [
		'map',
		'viewResolution',
		'viewSurface'
	],
	#category : #'MSeven-POC'
}

{ #category : #accessing }
MSevenPOC2 class >> start [
	<script>
	
	self new.
]

{ #category : #'pyramid-serialized-bloc' }
MSevenPOC2 class >> view [
	"This class has been generated using Pyramid.

	By: labordep
	2023-10-12 23:47:28"

	<pySTON>
	^ '[
	MSevenAeSurfaceBlElement {
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
			#background : BlTransparentBackground {
				
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #Map
			}
		},
		#layout : BlFlowLayout {
			#measurer : BlFlowLayoutMeasurer {
				#layout : @15,
				#children : OrderedCollection [ ],
				#lines : OrderedCollection [
					BlFlowLayoutLine {
						#children : OrderedCollection [ ],
						#startLength : 0,
						#startBreadth : 0,
						#length : 0,
						#breadth : 0,
						#measurer : @16
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
					#mode : @23
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
MSevenPOC2 >> initialize [ 
	
	| view space |
	super initialize.
	
	viewResolution := 256@240.
	view := self class view materializeAsBlElement first.
		
	space := view openInSpace.
	self initializeMap: MSevenResources ground_checkerboard.
	
	view surface: viewSurface.
	
	[ | position |
	
		position := 0@0.
		[space isOpened] whileTrue:[ | angle time |
			position ifNil:[position := 0@0].
			time := [position := position + (0.01@0).
			angle := (position x * 0.3) sin.
			self moveCameraToPosition: position angle: angle] timeToRun asMilliSeconds.
			((16 - time) max: 1) milliSeconds wait.
			view invalidate.
		].
	
	] forkAt: Processor userBackgroundPriority named: 'M-SevenPOC2'. 
]

{ #category : #initialization }
MSevenPOC2 >> initializeMap: aForm [

	map := aForm.
	
	"prepare view texture buffer"
	viewSurface := AeCairoImageSurface extent: viewResolution format: AeCairoSurfaceFormat argb32.
	viewSurface newContext sourceColor: Color black; rectangle: (0@0 extent: viewResolution); fill.
]

{ #category : #initialization }
MSevenPOC2 >> moveCameraToPosition: aPoint angle: anAngle [

	| width height halfWidth halfHeight focalLens scale position sin cos beginHeight viewContext |
	width := viewResolution x.
	height := viewResolution y.
	halfWidth := (viewResolution x / 2) asInteger.
	halfHeight := (viewResolution y / 2) asInteger.
	focalLens := 250.
	scale := 100.
	position := aPoint.
		
	sin := anAngle sin.
	cos := anAngle cos.
	
	beginHeight := height * 0.3.

	viewSurface flush.	
	viewContext := viewSurface newContext.
		
	"iterating over the screen array"
	1 to: width do:[ :i | 
		beginHeight to: height do:[ :j | | x y z px py rx ry floorPos floorColor attenuation |
			"x y z"
			x := halfWidth - i.
			y := j + focalLens.
			z := j - beginHeight + 0.01.
			
			"rotation"
			rx := (x * cos) - (y * sin).
			ry := (x * sin) + (y * cos).
			
			"projection"
			px := rx / z + (position y) * scale.
			py := ry / z + (position x negated) * scale.
			
			"floor pixel pos and color"
			floorPos := ((px \\ (map extent x)) asInteger) @ ((py \\ (map extent y)) asInteger). 
			floorColor := map colorAt: floorPos.
			
			"shading & fog"
			attenuation := (1.5 * ((z abs) / halfHeight)) max: 0; min: 1.
			floorColor := floorColor adjustBrightness: ((1 - (attenuation)) negated).
			
			"fill screen"
			viewContext sourceColor: floorColor; rectangle: (i@j extent: 1@1); fill.
		].
	].
]
