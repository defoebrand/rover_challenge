import { Controller } from "stimulus"

export default class extends Controller {  
  static values = { x: Number, y: Number, direction: String } 

  currentPosition(){
    return {
      grid: document.getElementById('rover_grid').getBoundingClientRect(),
      xCoord: this.xValue,
      yCoord: this.yValue
    }
  }
  
  gridSize(){
    const position = this.currentPosition();
  
    return {
      height: Math.round(position.grid.height / 5),
      width: Math.round(position.grid.width / 5)
    }
  }
  
  connect(){
    window.onresize = () => this.positionRover();
    
    this.positionRover();
  }
  
  positionRover(){
    const position = this.currentPosition();
    const square = this.gridSize();
    const rover = document.getElementById('rover_image');

    rover.style.top = (position.grid.bottom - (rover.naturalHeight / 2) - (this.yValue * square.height)) + 'px'
    rover.style.left = (position.grid.left - (rover.naturalWidth / 2) + (this.xValue * square.width)) + 'px'
    
    this.rotate(this.directionValue, rover);
  }

  move_rover(e){
    e.preventDefault();
  }

  rotate(direction, rover_image){
    rover_image.classList.remove('east')

    switch (direction) {
      case 'N':
        rover_image.classList.add('north')
        break;
      case 'E':
        rover_image.classList.add('east')
        break;
      case 'S':
        rover_image.classList.add('south')
        break;
      case 'W':
        rover_image.classList.add('west') 
        break;
      }
  }
 }
