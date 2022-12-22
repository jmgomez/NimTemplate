## NimTemplate
<img src="https://raw.githubusercontent.com/jmgomez/NimForUE/master/logo.png" width="240"  align="right">

Template project for NimForUE: https://github.com/jmgomez/NimForUE



NimForUE is Nim plugin for UE5 that provides native performance, hot reloading, and full interop between C++ and Blueprints. With this plugin, you can extend any UE class in Nim and then further extend it in Blueprint without restarting the editor. This allows for seamless integration with common UE workflows, allowing you to take advantage of the power of Nim in your UE projects.




## Getting Started in Windows:

Make sure you have Unreal Engine 5.1 installed and Nim 1.6.10 or above is in your path.

1. Clone the repository and its submodules:
```
git clone https://github.com/jmgomez/NimTemplate.git --recurse-submodules
```
2. Navigate to the NimForUE directory:
```
cd NimTemplate/Plugins/NimForUE
```
3. Set up the project using nimble:

```nimble setup```

This will build the project and all the necessary Nim files.

4. Open NimTemplate.uproject

5. When UE loads the plugin it will automatically generate all the bindings for the plugin listed in your game.

6. Once the bindings are generated, open game.nim in the root of the NimForUE directory in VSCode. There should be a task available to build the game DLL.

7. Restart the editor, this is only necessary the first time you compile your game.

8. Click play, click into the viewport to control the character. You're all set!



<img src="https://uc13b33d7d1e9ee3fe5817e6e048.previews.dropboxusercontent.com/p/thumb/ABvPwCeTIIppCPy77orA5CqAzP-ckIoDTUi89tz-DwwLK4Bcgsb1YOLCgu90JeimBkEFPHXONFid8y2WszEFK_zj9CixHLW6YHjWgwkwTGvWOt-hJqogXMaw4hSQkt0y0JWn1DUGopZYlNZUQTsqpWrpG2WfoJSBJKYCjN6CBSPFLNJ-2xrpJ2flCwL2W8D_Xwt7Q0KzXOKsFrE0CAglFjQ4BU_MwFvC0RvS1MNj-fg1-Jtvy1irPQAMch24u454wQ48ogUGOrNedDKKwZckWWc2BgZkugmb3aC-EYPb8kHEfmiB6PXE0c5hMDGMhEn6EAKOjiN7X7OpVSYSy1QFK95uBo1Wqs5sSzD0dhKgxsvgT-qxUdVFPatpY1TsjTo7sOqihYBm9_W3_FKed4ZjjJ0pKrfaDRmQQT-dBZ6oY8QFlQ/p.jpeg" width="720"  >

