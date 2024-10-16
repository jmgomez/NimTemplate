

NimForUE

Outline

The idea of the presentation is to show how the different bindings work and how you can use them


ThirdPersonTemplate (game.nim)

How the bindings are generated and PCH Types (i.e. `virtual` allowance)
 Automatic generated:
 - Regular reflected bindings 
  - Exported vs Imported: speed up Nim compilation times
 - PCH Bindings

Interactor (interactor.nim)
 - Collision
 - Delegate
 - Hooked in game.nim
  
MvvmPlugin setup 
 - Activate the plugin in the UI
 - game.json (extension point for linking)
 - nuegame.h (extension point for the PCH)

UI
 - UMG
 - Widget Blueprint Editor
 - ViewModel: 
   - OneWay
   - TwoWay
   - Bind functions
   - Converters
 -  

