RSpec.describe 'RoverCoordinate' do
  describe 'GET #new' do
    it 'returns successful response' do
      get root_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:rover) { create(:rover_coordinate) }

    it 'returns successful response' do
      get results_path(rover: [rover.id])

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    describe 'redirects to show page' do
      let(:good_params) do
        { rover_params: { xCoord: '1', yCoord: '2', direction: 'N', instructions: 'LMLMLMLMM', grid_size: [5, 5] } }
      end

      let(:missing_grid) do
        { rover_params: { xCoord: '1', yCoord: '2', direction: 'N', instructions: 'LMLMLMLMM' } }
      end

      it 'if all params are present' do
        post calculate_path, params: good_params

        expect(response).to have_http_status(:redirect)
      end

      it 'without grid_size and accepts default of [5, 5]' do
        post calculate_path, params: missing_grid

        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'flashes failure notice' do
      let(:missing_instructions) do
        { rover_params: { xCoord: '1', yCoord: '2', direction: 'N', grid_size: [5, 5] } }
      end

      it 'if params are missing instructions' do
        post calculate_path, params: missing_instructions

        expect(flash[:notice]).to match('Something went wrong. Please try running your simulation again!')
      end
    end

    describe 'redirects to new form' do
      let(:missing_x_coord) do
        { rover_params: { yCoord: '2', direction: 'N', instructions: 'LMLMLMLMM' } }
      end

      let(:missing_y_coord) do
        { rover_params: { xCoord: '1', direction: 'N', instructions: 'LMLMLMLMM' } }
      end

      it 'if params are missing xCoord' do
        post calculate_path, params: missing_x_coord

        expect(response).to have_http_status(:redirect)
      end

      it 'if params are missing yCoord' do
        post calculate_path, params: missing_y_coord

        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
