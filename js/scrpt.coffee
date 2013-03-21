randomVal = (minVal, maxVal) ->
  (maxVal - minVal) * Math.random() + minVal


class Line
  LineNum = 50
  frict = 0.9

  constructor: (@context, @wid, @hig)->
    this.lastPos = []
    this.pos = []
    this.velocity = []
    this.friction = []
    this.ease = []

    for i in [0..LineNum-1]
      @pos[i] = {x: @wid * randomVal(.1, .9), y: @hig * randomVal(0.1, 0.9)}
      @lastPos[i] = {x: @pos[i].x, y: @pos[i].y}
      @velocity[i] = {x: 0, y:0}
      @friction[i] = {x: randomVal(10, 40), y: randomVal(10, 40)}
      @ease[i] = {x: randomVal(2, 10), y: randomVal(2, 10)}

  update: (mouseX, mouseY)->
    for i in [0..LineNum-1]

      @lastPos[i].x = @pos[i].x
      @lastPos[i].y = @pos[i].y

      @pos[i].x += @velocity[i].x
      @pos[i].y += @velocity[i].y

      @velocity[i].x += (((mouseX - @pos[i].x) * @ease[i].x) - @velocity[i].x) / @friction[i].x
      @velocity[i].y += (((mouseY - @pos[i].y) * @ease[i].y) - @velocity[i].y) / @friction[i].y

      @velocity[i].x *= frict
      @velocity[i].y *= frict

  draw: ()->
    for i in [0..LineNum-2]
      @context.lineCap = 'round'
      @context.lineJoin = 'round'
      @context.beginPath()
      @context.strokeStyle = "#fff"
      @context.moveTo(@lastPos[i].x, @lastPos[i].y)
      @context.lineTo(@pos[i].x, @pos[i].y)
      @context.stroke()
      @context.closePath()

mobileStatus
agent = navigator.userAgent

if agent.search(/iPhone/) != -1 || agent.search(/iPad/) != -1 || agent.search(/iPod/) != -1 || agent.search(/Android/) != -1
  mobileStatus = true;
else
 mobileStatus = false;


window.requestAnimationFrame = do ->
  window.requestAnimationFrame       ||
  window.webkitRequestAnimationFrame ||
  window.mozRequestAnimationFrame    ||
  window.oRequestAnimationFrame      ||
  window.msRequestAnimationFrame     ||
  (callback) -> window.setTimeout(callback, 1000 / 60)

wid = window.innerWidth
hig = window.innerHeight

mouseX = wid / 2
mouseY = hig / 2


canvas = document.getElementById("myCanvas")
canvas.width = wid
canvas.height = hig

context = canvas.getContext("2d")
context.fillStyle = "#000"
context.fillRect(0, 0, wid, hig)

myLine = new Line(context, wid, hig)

touch_move = (e)->
  touch = e.touches[0]
  mouseX = touch.pageX
  mouseY = touch.pageY

  e.preventDefault()


mouse_move = (e)->
  mouseX = e.x
  mouseY = e.y


if(mobileStatus)
  document.addEventListener("touchmove", touch_move)
else
  document.addEventListener("mousemove", mouse_move)


clear = ->
  context.fillStyle = "rgba(0, 0, 0, .05)"
  context.fillRect(0, 0, wid, hig)

step = ->
  clear()
  myLine.update(mouseX, mouseY)
  myLine.draw();

  requestAnimationFrame(step)


step()

