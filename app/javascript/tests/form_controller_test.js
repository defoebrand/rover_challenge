import { Application } from 'stimulus';
import FormController from '../controllers/form_controller.js';

const startStimulus = () => {
  const application = Application.start();
  application.register('form', FormController);
};

describe('ResultController', () => {
  describe('#move_rover', () => {
    beforeEach(() => {
      startStimulus();

      document.body.innerHTML = `
      <form class="container centered_flex column_flex mt-5" data-controller="form" action="/calculate" accept-charset="UTF-8" method="post">
        <p class="hide_until_active" data-form-target="error" id="errorMessage"></p>
        <label class="axis_label">
          X:
          <div class="m-2">
            <input placeholder="Starting X coordinate" data-action="input->form#move_by_form" data-form-target="xCoord" min="0" max="5" type="number" name="rover_params[xCoord]" id="rover_params_xCoord">
          </div>
        </label>
        <label class="axis_label">
          Y:
          <div class="m-2">
            <input placeholder="Starting Y coordinate" data-action="input->form#move_by_form" data-form-target="yCoord" min="0" max="5" type="number" name="rover_params[yCoord]" id="rover_params_yCoord">
          </div>
        </label>
        <div class="m-2">
          <select data-action="change->form#rotate" data-form-target="direction" name="rover_params[direction]" id="rover_params_direction">
            <option value="">Starting Direction - East</option>
            <option value="N">North</option>
            <option value="E">East</option>
            <option value="S">South</option>
            <option value="W">West</option>
          </select>
        </div>
        <div class="m-2">
          <input placeholder="Instructions" data-form-target="instructions" data-action="input->form#sanitize_input" type="text" name="rover_params[instructions]" id="rover_params_instructions">
        </div>
        <input type="submit" name="commit" value="Submit" class="m-3" data-action="click->form#submit" data-disable-with="Submit">
      </form>`;
    });

    it('displays error if inputs are absent upon form submission', () => {
      const button = document.querySelector('input[type=\'submit\']');
      button.click();
      const error_message = document.querySelector('.error_message_style')

      expect(error_message).toBePresent;
    });
  });
});