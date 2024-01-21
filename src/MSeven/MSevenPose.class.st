Class {
	#name : #MSevenPose,
	#superclass : #Object,
	#instVars : [
		'position',
		'orientation'
	],
	#category : #'MSeven-Model'
}

{ #category : #initialization }
MSevenPose >> copy [

	| copy |
	copy := self class new.
	copy orientation: self orientation copy.
	copy position: self position copy.
	^ copy
]

{ #category : #initialization }
MSevenPose >> initialize [ 

	super initialize.
	self position: BlPoint3D new.
	self orientation: BlVector3D zero.
]

{ #category : #accessing }
MSevenPose >> orientation [

	^ orientation ifNil:[ orientation := BlVector3D new ]
]

{ #category : #accessing }
MSevenPose >> orientation: aBlVector3D [

	orientation := aBlVector3D
]

{ #category : #accessing }
MSevenPose >> pitch [

	^ self orientation z
]

{ #category : #accessing }
MSevenPose >> pitch: anAngle [

	self orientation:
		(BlVector3D x: self orientation x y: self orientation y z: anAngle)
]

{ #category : #accessing }
MSevenPose >> position [

	^ position ifNil:[ position := BlPoint3D new ]
]

{ #category : #accessing }
MSevenPose >> position: aBlPoint3D [

	position := aBlPoint3D
]

{ #category : #accessing }
MSevenPose >> roll [

	^ self orientation x
]

{ #category : #accessing }
MSevenPose >> roll: anAngle [

	self orientation:
		(BlVector3D x: anAngle y: self orientation y z: self orientation z)
]

{ #category : #accessing }
MSevenPose >> x [

	^ self position x
]

{ #category : #accessing }
MSevenPose >> x: aFloat [

	self position: (BlPoint3D x: aFloat y: self position y z: self position z)
]

{ #category : #accessing }
MSevenPose >> y [

	^ self position y
]

{ #category : #accessing }
MSevenPose >> y: aFloat [

	self position: (BlPoint3D x: self position x y: aFloat z: self position z)
]

{ #category : #accessing }
MSevenPose >> yaw [

	^ self orientation y
]

{ #category : #accessing }
MSevenPose >> yaw: anAngle [

	self orientation:
		(BlVector3D x: self orientation x y: anAngle z: self orientation z)
]

{ #category : #accessing }
MSevenPose >> z [

	^ self position z
]

{ #category : #accessing }
MSevenPose >> z: aFloat [

	self position: (BlPoint3D x: self position x y: self position y z: aFloat)
]
