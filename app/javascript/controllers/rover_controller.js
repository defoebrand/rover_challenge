import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [ 'roverGrid', 'roverImage' ]

  currentPosition(){
    return {
      grid: this.roverGridTarget.getBoundingClientRect(),
      yCoord: document.getElementById('rover_params_yCoord'),
      xCoord: document.getElementById('rover_params_xCoord')
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

  clearErrors(){
    const error = document.getElementById('errorMessage');

    if(error.textContent){
      error.classList.remove('error_message_style');
      error.classList.add('hide_until_active');
      error.textContent = '';
    }
  }

  positionRover(){
    const position = this.currentPosition();
    const square = this.gridSize();
    const rover = this.roverImageTarget;

    rover.style.top = (position.grid.bottom - (rover.naturalHeight / 2) - ((position.yCoord.value || 0) * square.height)) + 'px';
    rover.style.left = (position.grid.left - (rover.naturalWidth / 2) + ((position.xCoord.value || 0) * square.width)) + 'px';
  }

  move_rover(e){
    const position = this.currentPosition();
    const square = this.gridSize();
    const new_x = Math.round((e.clientX - position.grid.left) / square.width);
    const new_y = 5 - Math.round((e.clientY - position.grid.top) / square.height);

    if (new_x >= 0 && new_x <= 5 ) {position.xCoord.value = new_x;}
    if (new_y >= 0 && new_y <= 5) {position.yCoord.value = new_y;}

    this.clearErrors();

    this.positionRover();
  }

  rotate(e){
    const rover_image = e.currentTarge;
    const direction = rover_image.classList[0];
    const directionInput = document.getElementById('rover_params_direction');

    switch (direction) {
      case 'north':
        rover_image.classList.remove('north');
        rover_image.classList.add('east');
        directionInput.value = 'E';
        break;
      case 'east':
        rover_image.classList.remove('east');
        rover_image.classList.add('south');
        directionInput.value = 'S';
        break;
      case 'south':
        rover_image.classList.remove('south');
        rover_image.classList.add('west');
        directionInput.value = 'W';
        break;
      case 'west':
        rover_image.classList.remove('west');
        rover_image.classList.add('north');
        directionInput.value = 'N';
        break;
      }
    }
 }
