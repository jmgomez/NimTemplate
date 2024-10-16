include unrealprelude
import enhancedinput/enhancedinput
import interactor, ui


uClass ANimCharacter of ACharacter:
  uprops(EditAnywhere, BlueprintReadOnly, DefaultComponent, Category = Camera):
    cameraBoom : USpringArmComponentPtr 
  uprops(EditAnywhere, BlueprintReadOnly, DefaultComponent, Attach=(cameraBoom, SpringEndpoint), Category = Camera):
    followCamera : UCameraComponentPtr
  uprops(EditAnywhere, BlueprintReadOnly, Category = Input):
    defaultMappingContext : UInputMappingContextPtr
    (jumpAction, moveAction, lookAction): UInputActionPtr
  uprops:
    bFreezeLook: bool
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
  
  proc setupPlayerInputComponent(playerInputComponent: UInputComponentPtr) {.virtual, override.}  =    
    let pc = ueCast[APlayerController](self.getController())
    if pc.isNotNil():
      let inputComponent = ueCast[UEnhancedInputComponent](playerInputComponent)
      let subsystem = tryGetSubsystem[UEnhancedInputLocalPlayerSubsystem](pc).get()
      subsystem.addMappingContext(self.defaultMappingContext, 0)
      inputComponent.bindAction(self.jumpAction, ETriggerEvent.Triggered, self, n"jump")
      inputComponent.bindAction(self.jumpAction, ETriggerEvent.Completed, self, n"stopJumping")
      inputComponent.bindAction(self.moveAction, ETriggerEvent.Triggered, self, n"move")
      inputComponent.bindAction(self.lookAction, ETriggerEvent.Triggered, self, n"look")
      
  ufuncs:
    proc beginPlay() = 
      #Find the Interactor in the level and bind the onPlayerInteract event
      let interactor = self.getActorOfClass(AInteractor.subclass()).ueCast(AInteractor)
      if interactor.isNotNil:
        interactor.onPlayerInteract.addDynamic(self, onInteract)

    proc onInteract(bIsOver: bool) =
      let pc = self.getController.ueCast(APlayerController)
      pc.bShowMouseCursor = bIsOver
      self.bFreezeLook = bIsOver

    proc move(value: FInputActionValue) = 
      let 
        movementVector = value.axis2D()
        rot = self.getControlRotation()
        rightDir = FRotator(roll: rot.roll, yaw: rot.yaw).getRightVector()
        forwardDir = FRotator(yaw: rot.yaw).getForwardVector()
      self.addMovementInput(rightDir, movementVector.x, false) 
      self.addMovementInput(forwardDir, movementVector.y, false) 

    proc look(value: FInputActionValue) =
      if not self.bFreezeLook:
        let lookAxis = value.axis2D()
        self.addControllerYawInput(lookAxis.x)
        self.addControllerPitchInput(lookAxis.y)

uClass ANimGameMode of AGameModeBase:
  proc constructor(initializer: FObjectInitializer) = #Similar to default but allows you to write full nim code
    let classFinder = makeClassFinder[ACharacter]("/Game/ThirdPerson/Blueprints/BP_ThirdPersonCharacter")
    self.defaultPawnClass = classFinder.class
    self.hUDClass = ANimConfHUD.subclass()



