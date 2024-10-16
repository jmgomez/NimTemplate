include unrealprelude
import ui
import codegen/uebind
import umg/[blueprint, components]


uDelegate FOnPlayerInteractDelegate(bIsOver: bool)

uClass AInteractor of AActor:
  (BlueprintType, Blueprintable)
  uprops(EditAnywhere, BlueprintReadWrite, DefaultComponent, RootComponent):
    sphereCollision: USphereComponentPtr
  uprops(EditAnywhere, BlueprintReadWrite, DefaultComponent):
    widgetComponent: UWidgetComponentPtr
    staticMeshComponent: UStaticMeshComponentPtr
  
  uprops(BlueprintAssignable):
    onPlayerInteract: FOnPlayerInteractDelegate
  
  ufuncs:
    proc beginPlay() =
      self.sphereCollision.onComponentBeginOverlap.addDynamic(self, onOverlap)  
      self.sphereCollision.onComponentEndOverlap.addDynamic(self, onEndOverlap)

    proc onOverlap(overlappedComponent: UPrimitiveComponentPtr, otherActor: AActorPtr, otherComp: UPrimitiveComponentPtr, 
        otherBodyIdx: int32, bFromSweep: bool, sweepResult: var FHitResult) =
      if self.widgetComponent.getWidget.isNotNil:
        self.widgetComponent.getWidget.addToViewport()
        self.onPlayerInteract.broadcast(true)
      else:
        UE_Error &"Widget is nil in {self.getName}"
    
    proc onEndOverlap(overlappedComponent: UPrimitiveComponentPtr, otherActor: AActorPtr, otherComp: UPrimitiveComponentPtr, 
        otherBodyIdx: int32) =
      if self.widgetComponent.getWidget.isNotNil:
        self.widgetComponent.getWidget.removeFromViewport()
        self.onPlayerInteract.broadcast(false)
