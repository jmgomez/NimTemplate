import std/[os, compilesettings, sequtils]
when querySetting(command) == "check":
  switch("define", "nimcheck")


let currentDir = getCurrentDir()

echo "Current dir is ", currentDir

var pluginDirs = 
  if fileExists(currentDir / "game.nim"): 
    @[getCurrentDir() / "../Plugins/NimForUE"]
  elif dirExists("NimForUE"): @["."]
  else:
    @[getCurrentDir() / "../../Plugins/NimForUE"]


pluginDirs = pluginDirs.filter(dirExists)
assert pluginDirs.len == 1
echo "Using plugin dir: ", $pluginDirs


proc setPath(pluginDir: string) = 
  switch("path", pluginDir)
  switch("path", pluginDir / "src")
  switch("path", pluginDir / "src/nimforue")
  switch("path", pluginDir / "src/nimforue/game")
  switch("path", pluginDir / "src/nimforue/unreal")
  switch("path", pluginDir / "src/nimforue/unreal/bindings/exported")
  switch("path", pluginDir / "src/nimforue/vm")
  when defined(nimsuggest): #only needed for script.nim and nimsuggest
    switch("path", pluginDir / "src/nimforue/unreal/bindings/vm")


for dir in pluginDirs:
  setPath(dir)

switch("backend", "cpp")

