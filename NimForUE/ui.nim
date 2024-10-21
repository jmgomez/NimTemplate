include unrealprelude
import umg/[umg, blueprint, components]
import modelviewviewmodel
import extras/modelviewviewmodel


uClass UWidgetBase of UUserWidget:
  (BlueprintType, Blueprintable)

uSection():

  uClass UTodoItemViewModel of UMVVMViewModelBase:
    (BlueprintType, Blueprintable)
    uprops(BlueprintReadWrite, FieldNotify):
      title: FText  
      bDone: bool
      bIsEditing: bool

    uprop():
      context: UObjectPtr

    ufuncs(BlueprintCallable):
      proc toggleEdit() =
        self.bIsEditing = not self.bIsEditing
        log "bIsEditing: " & $self.bIsEditing
        self.title = self.title

      proc setDone(bIsChecked: bool) =
        self.bDone = bIsChecked
        let listvm = getViewModelFromCollection(UTodoListViewModel, self.context)
        listvm.broadcastFieldValueChanged(n "items")

    ufuncs(Static):
      proc newTodoItemViewModel(title: FText, bDone: bool, context: UObjectPtr): UTodoItemViewModelPtr =
        result = newUObject[UTodoItemViewModel]()
        result.title = title
        result.bDone = bDone
        result.context = context

  uClass UTodoListViewModel of UMVVMViewModelBase:
    (BlueprintType, Blueprintable)
    uprops(BlueprintReadWrite, FieldNotify):
      items: TArray[UTodoItemViewModelPtr]

    ufuncs:
      proc addItem(item: UTodoItemViewModelPtr) =
        self.items.add(item)

      proc removeItem(item: UTodoItemViewModelPtr) =      
        self.items.remove(item)

      proc clearItems() =
        self.items = makeTArray[UTodoItemViewModelPtr]()


uClass ANimConfHUD of AHUD:
  ufuncs:
    proc beginPlay() = 
      let vm = UTodoListViewModel.addViewModelToCollection(self)
      vm.addItem(newTodoItemViewModel("Learn some Nim".toText(), true, self))
      vm.addItem(newTodoItemViewModel("Learn Unreal Engine 5.".toText(), true, self))
      vm.addItem(newTodoItemViewModel("Learn NimForUE.".toText(), true, self))
      vm.addItem(newTodoItemViewModel("Build an awesome game.".toText(), false, self))


#Converte examples
uClass UNimConvertersLibrary of UBlueprintFunctionLibrary:

  ufuncs(BlueprintPure, Static, BlueprintAutocast, Category="Nim"):
    proc convIntToText2(value: int32, bAlwaysSign: bool = false, bUseGrouping: bool = true, minimumIntegralDigits: int32 = 1, maximumIntegralDigits: int32 = 324): FText =
      "hello".toText()
  
    proc convertObjectToText(obj: UObjectPtr): FText = 
      if obj.isNil: "None".toText()
      else: obj.getName().toText()
    
    proc convertItemsToText(items: TArray[UTodoItemViewModelPtr]): FText =
        (&"{items.filterIt(it.bDone).num} of {items.num}").toText()


        
    proc selectTexture(value: bool, aTexture, bTexture: UTexture2DPtr, width, height: int32): FSlateBrush = 
      makeBrushFromTexture(if value: aTexture else: bTexture, width, height)
      
    proc selectBrush(value: bool, aBrush, bBrush: FSlateBrush): FSlateBrush = 
      if value: aBrush else: bBrush
    
    proc selectSlot(value: bool, aSlot, bSlot: UPanelSlotPtr): UPanelSlotPtr = 
      if value: aSlot else: bSlot
    
    proc negate(value: bool): bool = not value 
