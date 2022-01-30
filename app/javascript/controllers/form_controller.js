import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'error', 'xCoord', 'yCoord', 'direction', 'instructions' ]
  
  get xCoord() {
    return this.ensureNumberInRange(this.xCoordTarget);
  }
  
  get yCoord() {
    return this.ensureNumberInRange(this.yCoordTarget);
  }
  
  ensureNumberInRange(coord){
    if(coord.value < 0 || coord.value > 5){
      this.setError('Please choose a number from 0 - 5')
      coord.value = ''
    } else {
      this.clearError();
      return coord.value
    }
  }
  
  setError(message){
    const error = this.errorTarget
    
    if(!error.textContent){
      error.classList.remove('hide_until_active')
      error.classList.add('error_message_style')
      error.textContent = message
    }
  }
  
  clearError(){
    const error = this.errorTarget

    if(error.textContent){
      error.classList.remove('error_message_style')
      error.classList.add('hide_until_active')
      error.textContent = ''
    }
  }
  
  sanitize_input(e){
    const acceptedInputs = ['L', 'l', 'R', 'r', 'M', 'm']
    const instructions = this.instructionsTarget
    
    if (acceptedInputs.indexOf(e.data) >= 0) {
      this.clearError();
      
      instructions.value = instructions.value.toUpperCase()
    } else {
      instructions.value = instructions.value.slice(0, -1)
    }
  }
  
  submit(e){
    this.directionTarget.value = this.directionTarget.value || 'E'
    
    const missingInputs = [
      this.yCoord, 
      this.xCoord, 
      this.instructionsTarget.value
    ].some((elem) => !elem)
     
    if(missingInputs){
      this.setError('Please fill out all inputs')
      
      e.preventDefault()
    }
  }
  
  move_by_form(){
    const grid = document.getElementById('rover_grid').getBoundingClientRect();
    const rover = document.getElementById('rover_image')
    
    rover.style.top = (grid.bottom - (rover.naturalHeight / 2) - (this.yCoord * Math.round(grid.height / 5))) + 'px'
    
    rover.style.left = (grid.left - (rover.naturalWidth / 2) + (this.xCoord * Math.round(grid.width / 5))) + 'px'
   }
   
  rotate(){
    const directionValue = this.directionTarget.value
    const roverImage = document.getElementById('rover_image')

    rover_image.className = ''
    
    if (directionValue == 'N'){
      rover_image.classList.add('north')
    } else if (directionValue == 'E') {
      rover_image.classList.add('east')
    } else if (directionValue == 'S') {
      rover_image.classList.add('south')
    } else if (directionValue == 'W') {
      rover_image.classList.add('west')
    }
  }
}
