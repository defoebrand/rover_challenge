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
      get results_path(rover: rover)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:params) do
      { rover_params: { xCoord: '1', yCoord: '2', direction: 'N', instructions: 'LMLMLMLMM' } }
    end

    it 'redirects to show page' do
      post calculate_path, params: params

      expect(response).to have_http_status(:redirect)
    end
  end
end
