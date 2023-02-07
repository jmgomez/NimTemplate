include unrealprelude
import enhancedinput

import examples/asyncexample


uClass ANimCharacter of ACharacter:
  (config=Game)
  uprops(EditAnywhere, BlueprintReadOnly, DefaultComponent, Category = Camera):
    cameraBoom : USpringArmComponentPtr 
  uprops(EditAnywhere, BlueprintReadOnly, DefaultComponent, Attach=(cameraBoom, SpringEndpoint), Category = Camera):
    followCamera : UCameraComponentPtr
  uprops(EditAnywhere, BlueprintReadOnly, DefaultComponent, Category = Input):
    inputComponent : UEnhancedInputComponentPtr
  uprops(EditAnywhere, BlueprintReadOnly, Category = Input):
    defaultMappingContext : UInputMappingContextPtr
    (jumpAction, moveAction, lookAction) : UInputActionPtr

  defaults: # default values for properties on the cdo
    capsuleComponent.capsuleRadius = 40
    capsuleComponent.capsuleHalfHeight = 96
    bUseControllerRotationYaw = false
    characterMovement.jumpZVelocity = 700
    characterMovement.airControl = 0.35
    characterMovement.maxWalkSpeed = 500
    characterMovement.minAnalogWalkSpeed = 20
    characterMovement.brakingDecelerationWalking = 2000
    characterMovement.bOrientRotationToMovement = true
    cameraBoom.targetArmLength = 400
    cameraBoom.busePawnControlRotation = true
    followCamera.bUsePawnControlRotation = true
    
  
  ufuncs():
    proc beginPlay() = 
      let pc = ueCast[APlayerController](self.getController())
      if pc.isNotNil():
        let subsystem = getSubsystem[UEnhancedInputLocalPlayerSubsystem](pc).get()
        subsystem.addMappingContext(self.defaultMappingContext, 0)
        self.inputComponent.bindAction(self.jumpAction, ETriggerEvent.Triggered, self, n"jump")
        self.inputComponent.bindAction(self.jumpAction, ETriggerEvent.Completed, self, n"stopJumping")
        self.inputComponent.bindAction(self.moveAction, ETriggerEvent.Triggered, self, n"move")
        self.inputComponent.bindAction(self.lookAction, ETriggerEvent.Triggered, self, n"look")
    proc move(value: FInputActionValue) = 
      let 
        movementVector = value.axis2D()
        rot = self.getControlRotation()
        rightDir = FRotator(roll: rot.roll, yaw: rot.yaw).getRightVector()
        forwardDir = FRotator(yaw: rot.yaw).getForwardVector()
      self.addMovementInput(rightDir, movementVector.x, false) 
      self.addMovementInput(forwardDir, movementVector.y, false) 

    proc look(value: FInputActionValue) =
      let lookAxis = value.axis2D()
      self.addControllerYawInput(lookAxis.x)
      self.addControllerPitchInput(lookAxis.y)

uClass ANimGameMode of AGameModeBase:
  proc constructor(init:FObjectInitializer) = #Similar to default but allows you to write full nim code
    let classFinder = makeClassFinder[ACharacter]("/Game/ThirdPerson/Blueprints/BP_ThirdPersonCharacter")
    self.defaultPawnClass = classFinder.class



