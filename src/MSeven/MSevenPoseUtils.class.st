"
Utils class to manage coordinates
"
Class {
	#name : #MSevenPoseUtils,
	#superclass : #Object,
	#category : #'MSeven-Model'
}

{ #category : #'API -- move' }
MSevenPoseUtils class >> moveBackwardPose: aPose speed: aSpeed [
	"Move backward a pose, return a new pose"
	
	| cos sin speedCos speedSin offset position newPosition newPose |
	cos := aPose yaw cos.
	sin := aPose yaw sin.
	speedCos := aSpeed * cos.
	speedSin := aSpeed * sin.
	
	offset := BlPoint3D x: (speedCos) y: (speedSin) z: 0.
	position := aPose position.
	
	newPosition := position + offset.
	
	newPose := aPose copy.
	newPose position: newPosition.
	
	^ newPose
		
	
]

{ #category : #'API -- move' }
MSevenPoseUtils class >> moveDownPose: aPose speed: aSpeed [
	
	| newPose newAltitude |
	newAltitude := aPose z - aSpeed.
	
	newPose := aPose copy.
	newPose z: (newAltitude max: 0).
	
	^ newPose
]

{ #category : #'API -- move' }
MSevenPoseUtils class >> moveForwardPose: aPose speed: aSpeed [
	"Move forward a pose, return a new pose"
	
	| cos sin speedCos speedSin offset position newPosition newPose |
	cos := aPose yaw cos.
	sin := aPose yaw sin.
	speedCos := aSpeed * cos.
	speedSin := aSpeed * sin.
	
	"Calculate the offset based on speed and orientation"
	offset := BlPoint3D x: (speedCos negated) y: (speedSin negated) z: 0.
	
	position := aPose position.
	
	newPosition := position + offset.
	
	newPose := aPose copy.
	newPose position: newPosition.
	
	^ newPose
		
	
]

{ #category : #'API -- move' }
MSevenPoseUtils class >> moveLeftSidePose: aPose speed: aSpeed [
	"Move left side a pose, return a new pose"
	
	| cos sin speedCos speedSin offset position newPosition newPose |
	cos := aPose yaw cos.
	sin := aPose yaw sin.
	speedCos := aSpeed * cos.
	speedSin := aSpeed * sin.
	
	offset := BlPoint3D x: (speedCos negated) y: (speedSin) z: 0.
	position := aPose position.

	newPosition := position + offset.
	
	newPose := aPose copy.
	newPose position: newPosition.
	
	^ newPose
		
	
]

{ #category : #'API -- move' }
MSevenPoseUtils class >> moveRightSidePose: aPose speed: aSpeed [
	"Move right side a pose, return a new pose"
	
	| cos sin speedCos speedSin offset position newPosition newPose |
	cos := aPose yaw cos.
	sin := aPose yaw sin.
	speedCos := aSpeed * cos.
	speedSin := aSpeed * sin.
	
	offset := BlPoint3D x: (speedCos) y: (speedSin negated) z: 0.
	position := aPose position.
	
	newPosition := position + offset.
	
	newPose := aPose copy.
	newPose position: newPosition.
	
	^ newPose
		
	
]

{ #category : #'API -- move' }
MSevenPoseUtils class >> moveUpPose: aPose speed: aSpeed [
	
	| newPose newAltitude |
	newAltitude := aPose z + aSpeed.
	
	newPose := aPose copy.
	newPose z: (newAltitude max: 0).
	
	^ newPose
]

{ #category : #'API -- move' }
MSevenPoseUtils class >> turnLeftPose: aPose angle: anAngleInRadians [
	
	| newYaw newPose |
	newYaw := aPose yaw - anAngleInRadians.
	
	newPose := aPose copy.
	newPose yaw: newYaw.
	
	^ newPose
]

{ #category : #'API -- move' }
MSevenPoseUtils class >> turnRightPose: aPose angle: anAngleInRadians [
	
	| newYaw newPose |
	newYaw := aPose yaw + anAngleInRadians.
	
	newPose := aPose copy.
	newPose yaw: newYaw.
	
	^ newPose
]

{ #category : #'see class side' }
MSevenPoseUtils >> seeClassSide [ 
]
