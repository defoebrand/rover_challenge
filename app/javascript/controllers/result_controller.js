import { Controller } from 'stimulus';

class ResultController extends Controller {
  static values = { x: Number, y: Number, direction: String }

  currentPosition(){
    return {
      grid: document.getElementById('rover_grid').getBoundingClientRect(),
      xCoord: this.xValue,
      yCoord: this.yValue
    };
  }

  gridSize(){
    const position = this.currentPosition();

    return {
      height: Math.round(position.grid.height / 5),
      width: Math.round(position.grid.width / 5)
    };
  }

  connect(){
    window.onresize = () => this.positionRover();

    this.positionRover();
  }

  positionRover(){
    const position = this.currentPosition();
    const square = this.gridSize();
    const rover = document.getElementById('rover_image');

    rover.style.top = (position.grid.bottom - (rover.naturalHeight / 2) - (this.yValue * square.height)) + 'px';
    rover.style.left = (position.grid.left - (rover.naturalWidth / 2) + (this.xValue * square.width)) + 'px';

    rover.classList.remove('east');

    switch (this.directionValue) {
      case 'N':
        rover.classList.add('north');
        break;
      case 'E':
        rover.classList.add('east');
        break;
      case 'S':
        rover.classList.add('south');
        break;
      case 'W':
        rover.classList.add('west');
        break;
      }
  }

  move_rover(e){
    e.preventDefault();
  }

  rotate(e){
    e.preventDefault();
  }
}

export default ResultController;
